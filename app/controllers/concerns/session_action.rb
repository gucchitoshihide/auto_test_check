module SessionAction
  extend ActiveSupport::Concern

  def session_required
    unless session[:id]
      redirect_to logins_path, alert: 'You should login'
    end
  end

end
