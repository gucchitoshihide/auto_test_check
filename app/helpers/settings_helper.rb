module SettingsHelper
  def tab_group
    Settings[:settings][:tab][:group]
  end

  def activate_if_same(judge_base, obj)
    judge_base == obj ? 'active' : nil
  end
end
