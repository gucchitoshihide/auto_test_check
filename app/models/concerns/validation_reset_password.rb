module ValidationResetPassword
  extend ActiveSupport::Concern

  def validate_email_reset_password(email)
    validate_email_format(email) 
  end

  def validate_password_reset_password(password, password_confirmation)
    validate_blank_reset_password(password, password_confirmation)
    validate_not_match_reset_password(password, password_confirmation)
  end

  private

  def validate_blank_reset_password(password, password_confirmation)
    @errors << I18n.t('las.reset_password.message.alert.password.blank') if password.blank? or password_confirmation.blank?
  end

  def validate_not_match_reset_password(password, password_confirmation)
    @errors << I18n.t('las.reset_password.message.alert.password.not_match') if password != password_confirmation
  end

  def validate_email_format(email)
    unless email =~ /\A#{Settings[:reset_passwords][:email][:format]}\z/
      @errors << I18n.t('las.reset_password.message.alert.email.invalid_format')
    end
  end
end
