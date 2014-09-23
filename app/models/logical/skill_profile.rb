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

    def rewrite(params, current_user)
      begin
        @errors = []
        validate_skill_profile_edit(params)
        raise ValidationError Error.join(@errors) if @errors.present?
        # written_style saving is needed at this time
        current_user.skill_profile.article.update_attributes!(content: params[:content], written_style: current_user.write_style)
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
