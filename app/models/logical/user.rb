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

    def certificate(email_token)
      reset_password = ResetPassword.find_by_token!(email_token)
      raise CertificationError if reset_password.resend_at < Settings[:back][:reset_passwords][:expirenation]
      reset_token(reset_password)
      reset_password.user
    end

    def request_reset_password(params)
      user = find_by_email(params[:email])
      user.send_reset_password_email if user.present?
    end

    def format_error_message(error_message)
      error_message.split(Settings[:back][:model][:error][:seperate])
    end

    private

    def reset_token(reset_password)
      reset_password.token = nil
      reset_password.save
    end

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
    self.reset_password = ResetPassword.new
    generate_token
    send_mail
  end

  def send_mail
    self.reset_password[:resend_at] = Time.now
    self.reset_password.save!
    Announce.resend_password(self).deliver
  end

  def generate_token
    self.reset_password.token = SecureRandom.urlsafe_base64
    self.reset_password.save!
  end

end
