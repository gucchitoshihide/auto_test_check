require 'las_errors'

class SkillProfile < ActiveRecord::Base
  include RelationSkillProfile

  scope :latest, ->(list_num = Settings.skill_profile.show_list.max_num) {
    order('created_at DESC').limit(list_num)
  }

  class << self
    def submit(params, user_id)
      skill_profile = SkillProfile.new(title: params[:title], user_id: user_id)
      if skill_profile.save
        begin
          skill_profile.create_article(title: params[:title], content: params[:content], written_style: skill_profile.user.write_style)
        rescue ActiveRecord::StatementInvalid
          skill_profile.delete
          raise ValidationError, 'Detect All Validation'
        end
      else
        raise ValidationError, active_model_errors_to_string(profile)
      end
    end

    def rewrite(article_obj, params, current_user)
      begin
        article_obj.update_attributes!(content: params[:content], written_style: current_user.write_style)
      rescue ActiveRecord::RecordInvalid => e
        raise ValidationError, active_model_errors_to_string(profile)
      end
    end

    def search(params)
      params_search_key = Settings.skill_profile.form.object.search.to_sym
      found_records = Search::Word.reg_exp(Article.where.not(skill_profile_id: nil), :content, params[params_search_key])
      return [] if found_records.blank?
      found_records.map { |record| record.skill_profile }
    end

    def format_error_message(error_message)
      error_message.split(Settings[:error][:seperate])
    end

    private

    def active_model_errors_to_string(errored_model_obj)
      errored_model_obj.errors.messages.values.flatten.join(Settings[:error][:seperate])
    end
  end

end
