module ValidationSettings
  extend ActiveSupport::Concern

  def validate_setting_password(user_id, current_password, password, password_confirmation)
    @errors = []
    settings_current_password_authenticate(user_id, current_password)
    settings_validate_blank(current_password, password, password_confirmation)
    settings_validate_match(password, password_confirmation)
  end

  private

  def settings_validate_blank(current_password, password, password_confirmation)
    @errors << I18n.t("las.error.message.password.blank.current_password")      if current_password.blank?
    @errors << I18n.t("las.error.message.password.blank.password")              if password.blank?
    @errors << I18n.t("las.error.message.password.blank.password_confirmation") if password_confirmation.blank?
  end

  def settings_current_password_authenticate(user_id, current_password)
    @errors << I18n.t('las.error.message.password.not_match.current_password') unless User.find_by_id(user_id).authenticate(current_password)
  end

  def settings_validate_match(password, password_confirmation)
    @errors << I18n.t('las.error.message.password.not_match.password') if password != password_confirmation
  end
end
