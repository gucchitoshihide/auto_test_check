module SessionAction
  extend ActiveSupport::Concern

  def session_required
    if session[:id].blank?
      redirect_to logins_path, alert: 'You should login'
    end
  end

end
