require 'las_errors'

class WeekReport < ActiveRecord::Base
  include RelationWeekReport

  scope :latest, ->(list_num = Settings[:front][:week_reports][:index][:table][:list_num]) {
    WeekReport.limit(list_num).map { |record| record.articles }.flatten
  }

  class << self
    # issue - No relation Article is produced when SystemError happened
    def submit(params)
      article = Article.new(params)
      if article.save
        unless article.week_reports << WeekReport.new
          raise SystemError, 'System Error happened, Try again'
        end
      else
        raise ValidationError, active_model_errors_to_string(article)
      end
    end

    def rewrite(article, params)
      begin
        article.update_attributes!(params)
      rescue ActiveRecord::RecordInvalid => e
        raise ValidationError, active_model_errors_to_string(article)
      end
    end

    def throw_away(report)
      report.destroy
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
