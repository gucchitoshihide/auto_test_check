require 'las_errors'

class User < ActiveRecord::Base
  include RelationUser
  has_secure_password

  class << self
    attr_accessor :errors

    def authenticate(params)
      validate_params(params)
      raise ValidationError, join_errors(@errors) if @errors.present?
      user = find_by_name(params[:name])
      unless (user and user.authenticate(params[:password]))
        raise AuthorizationError, 'username or password is invalid'
      end
      user
    end

    def request_reset_password(params)
      user = find_by_email(params[:email])
      user.send_reset_password_email if user.present?
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
        params[key].present? or @errors << I18n.t("las.logins.message.alert.blank.#{key}")
      end
    end

    def join_errors(errored_message)
      errored_message.join(Settings[:back][:model][:error][:seperate])
    end

  end

  def send_reset_password_email
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    Announce.resend_password(self).deliver
  end

  def generate_token(column)
    self[column] = SecureRandom.urlsafe_base64
  end

end
