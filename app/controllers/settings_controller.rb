class SettingsController < ApplicationController
  include SessionAction
  before_action :session_required
  before_action :prohibit_editing_other, only: [:edit]
  before_action :set_user, only: [:edit]

  def edit
    @tab = 'password'
  end

  def update
    @tab = params[:tab]
    begin
      User.update_settings(settings_params, params[:id], @tab)
    rescue ValidationError => e
      flash.now[:alert] = User.format_error_message(e.message)
      return render 'edit'
    end
    flash.now[:notice] = I18n.t('las.settings.message.notice.password.updated')
    render 'edit'
  end

  private

  def settings_params
    params.permit(:current_password, :password, :password_confirmation)
  end

  def prohibit_editing_other
    if session[:id] != params[:id].to_i
      render 'edit'
    end
  end

  def set_user
    @user = User.find_by_id(session[:id])
  end
end
