module ValidationLogins
  extend ActiveSupport::Concern

  def validate_login_params(params)
    validate_presence(params)
  end

  private

  def validate_presence(params)
    params.keys.each do |key|
        params[key].present? or @errors << I18n.t("las.logins.message.alert.blank.#{key}")
    end
  end
end
