module ValidationLogin
  extend ActiveSupport::Concern

  def validate_login_params(params)
    validate_login_name(params[:name])
    validate_login_password(params[:password])
  end

  private

  def validate_login_name(name)
    @errors << I18n.t('las.errors.login_name.blank') if name.blank?
    @errors << I18n.t('las.errors.login_name.long')  if name.length > Settings.login.name.max_length
  end

  def validate_login_password(password)
    @errors << I18n.t('las.errors.login_password.blank')   if password.blank?
    @errors << I18n.t('las.errors.login_password.long')    if password.length > Settings.login.password.max_length
    @errors << I18n.t('las.errors.login_password.invalid') unless password =~ /#{Settings.login.password.regexp}/
  end
end
