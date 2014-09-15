module ValidationAdmin
  extend ActiveSupport::Concern

  def validate_admin_params(params)
    validate_blank_admin_email(params[:email])
    validate_length_long_admin_email(params[:email])
    validate_blank_admin_password(params[:password])
    validate_length_long_admin_password(params[:password])
    validate_format_admin_password(params[:password])
  end

  private

  def validate_blank_admin_email(email)
    @errors << I18n.t('las.errors.admin_email.blank') if email.blank?
  end

  def validate_length_long_admin_email(email)
    @errors << I18n.t('las.errors.admin_email.long') if email.length > Settings[:admin][:constraint][:email][:length]
  end

  def validate_blank_admin_password(password)
    @errors << I18n.t('las.errors.admin_password.blank') if password.blank?
  end

  def validate_length_long_admin_password(password)
    @errors << I18n.t('las.errors.admin_password.long') if password.length > Settings[:admin][:constraint][:password][:length]
  end

  def validate_format_admin_password(password)
    @errors << I18n.t('las.errors.admin_password.invalid') unless  password =~ /#{Settings[:admin][:constraint][:password][:regexp]}/
  end
end
