module ApplicationHelper
  def user_owned?(record)
    record.user_id == session[:id]
  end
end
