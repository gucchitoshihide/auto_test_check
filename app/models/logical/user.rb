require 'las_errors'

class User < ActiveRecord::Base
  include RelationUser
  has_secure_password
  mount_uploader :avatar, AvatarUploader

  class << self
    include ValidationAvatar
    include ValidationSettings
    include ValidationResetPassword
    include ValidationLogins

    attr_accessor :errors

    def authenticate(params)
      @errors = []
      validate_login_params(params)
      raise ValidationError, join_errors(@errors) if @errors.present?
      user = find_by_name(params[:name])
      unless (user and user.authenticate(params[:password]))
        raise AuthorizationError, 'username or password is invalid'
      end
      user
    end

    def certificate(email_token)
      reset_password = ResetPassword.find_by_token!(email_token)
      raise CertificationError if (Date.today - reset_password.resend_at) >= Settings[:reset_passwords][:expirenation]
      reset_password.user
    end

    def update_password(token, params)
      @errors = []
      validate_password_reset_password(params[:password], params[:password_confirmation])
      raise ValidationError, join_errors(@errors) if @errors.present?
      user = ResetPassword.find_by_token!(token).user
      user.update_attributes(params)
    end

    def update_settings(params, user_id, tab_name)
      @errors = []
      case tab_name
      when 'password'
        validate_setting_password(user_id, params[:current_password], params[:password], params[:password_confirmation])
        raise ValidationError, join_errors(@errors) if @errors.present?
        update_settings_password(user_id, {password: params[:password], password_confirmation: params[:password_confirmation]})
      when 'avatar'
        validate_avatar(params)
        raise ValidationError, join_errors(@errors) if @errors.present?
        Avatar.update(user_id, params[:avatar])
      end
    end

    def request_reset_password(params)
      @errors = []
      validate_email_format(params[:email])
      raise ValidationError, join_errors(@errors) if @errors.present?
      user = find_by_email(params[:email])
      user.send_reset_password_email if user.present?
    end

    def format_error_message(error_message)
      error_message.split(Settings[:error][:seperate])
    end

    def reset_token(reset_password)
      reset_password.token = nil
      reset_password.save
    end

    private

    def update_settings_password(user_id, attributes)
      user = User.find_by_id(user_id)
      user.update(attributes)
    end

    def join_errors(errored_message)
      errored_message.join(Settings[:error][:seperate])
    end

  end

  def send_reset_password_email
    self.reset_password = ResetPassword.new(user_id: self.id)
    generate_token
    send_mail
  end

  def send_mail
    self.reset_password[:resend_at] = Date.today
    self.reset_password.save!
    Announce.resend_password(self).deliver
  end

  def generate_token
    self.reset_password.token = SecureRandom.urlsafe_base64
    self.reset_password.save!
  end
end
