class LoginsController < ApplicationController
  include SessionAction
  before_action :session_required, only: [:destroy]

  def index
  end

  def create
    begin
      user = User.authenticate(user_params)
      session[:id] = user.id
      redirect_to root_path
    rescue AuthorizationError, ValidationError => e
      flash.now[:alert] = User.format_error_message(e.message)
      render :index
    end
  end

  def destroy
    session[:id] = nil
    redirect_to logins_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation)
  end
end
