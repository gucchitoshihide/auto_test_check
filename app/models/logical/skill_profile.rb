require 'las_errors'

class SkillProfile < ActiveRecord::Base
  include RelationSkillProfile

  scope :latest, ->(list_num = Settings[:front][:skill_profile][:index][:table][:list_num]) {
    latest_article_ids = SkillProfile.limit(list_num).map { |record| record.article_id }
    latest_article_ids.map { |article_id| Article.find_by(id: article_id) }
  }

  class << self
    def submit(params, user_id)
      article = Article.new(params)
      if article.save
        unless (article.skill_profiles << SkillProfile.new(article_id: article.id, user_id: user_id))
          raise SystemError, 'System Error happened, Try again'
        end
      else
        raise ValidationError, active_model_errors_to_string(profile)
      end
    end

    def rewrite(profile, params)
      begin
        profile.update_attributes!(params)
      rescue ActiveRecord::RecordInvalid => e
        raise ValidationError, active_model_errors_to_string(profile)
      end
    end

    def throw_away(profile)
      profile.skill_profiles.each { |skill_profile| skill_profile.destroy }
      profile.comments.each       { |comment| comment.destroy }
      profile.destroy
    end

    def format_error_message(error_message)
      error_message.split(Settings[:back][:model][:error][:seperate])
    end

    private

    def active_model_errors_to_string(errored_model_obj)
      errored_model_obj.errors.messages.values.flatten.join(Settings[:back][:model][:error][:seperate])
    end
  end

end
