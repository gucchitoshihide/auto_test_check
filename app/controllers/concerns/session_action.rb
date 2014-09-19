module SessionAction
  extend ActiveSupport::Concern

  def session_required
    if session[:id].blank?
      flash[:alert] = [I18n.t('las.errors.login_session.not_loggedin')]
      redirect_to new_login_path
    end
  end

  def forbidden_blank_session
    if session[:id].blank?
      render_403
    end
  end
end
