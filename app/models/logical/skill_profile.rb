class SkillProfile < ActiveRecord::Base
  belongs_to :profile
  belongs_to :user

  scope :latest, ->(list_num = Settings[:front][:skill_profile][:index][:table][:list_num]) {
    Article.order('created_at DESC').limit(list_num)
  }

  class << self
    def submit(params)
      profile = Article.new(params)
      if profile.save
        SkillProfile.new(article_id: profile.id).save
      else
        raise ValidationError, active_model_errors_to_string(profile)
      end
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
