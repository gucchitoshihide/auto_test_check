require 'las_errors'

class WeekReport < ActiveRecord::Base
  include RelationWeekReport

  scope :latest, ->(list_num = Settings[:front][:week_reports][:index][:table][:list_num]) {
    Article.where.not(week_report_id: nil).order('created_at DESC').limit(list_num)
  }

  class << self
    # issue - No relation Article is produced when SystemError happened
    def submit(params)
      week_report = WeekReport.new
      article     = Article.new(params)
      if article.save
        raise SystemError unless week_report.save
        article.week_report_id = week_report.id
        article.save and week_report.update_attributes!(article_id: article.id) rescue raise SystemError
      else
        raise ValidationError, active_model_errors_to_string(report)
      end
    end

    def rewrite(report, params)
      begin
        report.update_attributes!(params)
      rescue ActiveRecord::RecordInvalid => e
        raise ValidationError, active_model_errors_to_string(report)
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
