class LoginsController < ApplicationController
  def index
  end

  def create
    begin
      User.authorize(user_params)
    rescue ValidationError => e
      flash.now[:alert] = User.format_error_message(e.message)
      render :index
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation)
  end
end
