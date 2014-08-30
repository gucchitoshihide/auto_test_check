class ResetPasswordsController < ApplicationController
  def new
  end

  def create
    begin
      User.request_reset_password(params)
      redirect_to root_url, notice: 'Email sent with inst. If do not come, please do it again'
    rescue
    end
  end

  def edit
    begin
      @user = User.find_by_password_reset_token!(params[:format])
    rescue ActiveRecord::NotFound => e
      # * old token or invalid access
      # * should judge expire?
    end
  end

  def update
    begin
      user = User.find_by_password_reset_token!(params[:format])
      user.update(reset_password_params)
      # should respond delete password_reset_token
    rescue ActiveRecord::NotFound => e
    end
  end

  private

  def reset_password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
