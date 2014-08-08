require 'las_errors'

class WeekReport < ActiveRecord::Base
  include RelationWeekReport

  scope :latest, ->(list_num = Settings[:front][:week_reports][:index][:table][:list_num]) {
    Report.order('created_at DESC').limit(list_num)
  }

  class << self
    def submit(params)
      report = Report.new(params)
      if report.save
        WeekReport.new(report_id: report.id).save
      else
        raise ValidationError, active_model_errors_to_string(report)
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
