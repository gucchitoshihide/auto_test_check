module SessionAction
  extend ActiveSupport::Concern

  def session_required
    if session[:id].blank?
      flash.now[:alert] = I18n.t('errors.login_session.not_loggedin')
      redirect_to new_login_path
    end
  end
end
