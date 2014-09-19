class LoginController < ApplicationController
  include SessionAction
  before_action :redirect_to_welcome,     only: [:new, :create]
  before_action :forbidden_blank_session, only: [:destroy]

  def new
  end

  def create
    begin
      user_resource = User.authenticate(login_params)
      session[:id]  = user_resource.id
      redirect_to welcome_path
    rescue AuthorizationError, ValidationError => e
      flash.now[:alert] = Flash.format_error_message(e.message)
      render :new
    end
  end

  def destroy
    session[:id] = nil
    redirect_to new_login_path
  end

  private

  def redirect_to_welcome
    redirect_to welcome_path if session[:id].present?
  end

  def login_params
    params.require(:user).permit(Settings.login.allowed_params)
  end
end
