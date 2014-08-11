require 'las_errors'

class User < ActiveRecord::Base
  has_secure_password

  class << self
    attr_accessor :errors

    def authorize(params)
      validate_params(params)
      raise ValidationError, join_errors(@errors) if @errors.present?
    end

    def format_error_message(error_message)
      error_message.split(Settings[:back][:model][:error][:seperate])
    end

    private

    def validate_params(params)
      @errors = []
      validate_presence(params)
    end

    def validate_presence(params)
      params.keys.each do |key|
        params[key].present? or @errors << "#{key} is not input"
      end
    end

    def join_errors(errored_message)
      errored_message.join(Settings[:back][:model][:error][:seperate])
    end
  end

end
