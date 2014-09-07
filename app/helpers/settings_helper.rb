module SettingsHelper
  def tab_group
    Settings[:settings][:tab][:group]
  end

  def activate_if_same(judge_base, obj)
    judge_base == obj ? 'active' : nil
  end

  def precheck_radio_tag_if_setting_activate(name, type)
    radio_button_tag name, type, (true if current_user.write_style == type)
  end
end
