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
      raise CertificationError if (Date.today - reset_password.resend_at) >= Settings[:back][:reset_passwords][:expirenation]
      reset_password.user
    end

    def update_password(token, params)
      validate_password(params[:password], params[:password_confirmation])
      user = ResetPassword.find_by_token!(token).user
      user.update_attributes(params)
    end

    def update_settings(params, user_id, tab_name)
      case tab_name
      when 'password'
        validate_three_passwords(user_id, params[:current_password], params[:password], params[:password_confirmation])
        update_settings_password(user_id, params[:password], params[:password_confirmation])
      end
    end

    def request_reset_password(params)
      validate_email(params[:email])
      user = find_by_email(params[:email])
      user.send_reset_password_email if user.present?
    end

    def format_error_message(error_message)
      error_message.split(Settings[:back][:model][:error][:seperate])
    end

    def reset_token(reset_password)
      reset_password.token = nil
      reset_password.save
    end

    private

    def validate_three_passwords(user_id, current_password, password, password_confirmation)
      @errors = []
      @errors << I18n.t('las.error.message.password.not_match.current_password') if find_by_id(user_id).authenticate(password)
      @errors << I18n.t("las.error.message.password.blank.current_password")     if current_password.blank?
      @errors << I18n.t("las.error.message.password.blank.password")             if password.blank?
      @errors << I18n.t("las.error.message.password.blank.password_confirmation")if password_confirmation.blank?
      @errors << I18n.t('las.error.message.password.not_match.password')         if password != password_confirmation
      raise ValidationError, join_errors(@errors) if @errors.present?
    end

    def update_settings_password(user_id, password, password_confirmation)
      user = User.find_by_id(user_id)
      user.update({password: password, password_confirmation: password_confirmation})
    end

    def validate_email(email)
      @errors = []
      validate_email_format(email)
      raise ValidationError, join_errors(@errors) if @errors.present?
    end

    def validate_email_format(email)
      unless email =~ /\A#{Settings[:back][:reset_passwords][:email][:format]}\z/
        @errors << I18n.t('las.reset_password.message.alert.email.invalid_format')
      end
    end

    def validate_password(password, password_confirmation)
      @errors = []
      validate_blank(password, password_confirmation)
      validate_not_match(password, password_confirmation)
      raise ValidationError, join_errors(@errors) if @errors.present?
    end

    def validate_blank(password, password_confirmation)
      @errors << I18n.t('las.reset_password.message.alert.password.blank') if password.blank? or password_confirmation.blank?
    end

    def validate_not_match(password, password_confirmation)
      @errors << I18n.t('las.reset_password.message.alert.password.not_match') if password != password_confirmation
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
