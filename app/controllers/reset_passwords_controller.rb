class ResetPasswordsController < ApplicationController
  before_action :back_to_root, only: [:new]

  def new
  end

  def create
    User.request_reset_password(params)
    render 'announce'
  end

  def announce
  end

  def edit
    begin
      binding.pry
      # use at form
      @user  = User.certificate(params[:format])
      @token = params[:format]
    rescue ActiveRecord::RecordNotFound, CertificationError => e
      render 'announce'
    end
  end

  def update
    begin
      user = User.find_by_password_token!(params[:format])
      user.update(reset_password_params)
      # should respond delete password_reset_token
    rescue ActiveRecord::NotFound => e
    end
  end

  def finish
  end

  private

  def reset_password_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def back_to_root
    redirect_to root_path if session[:id]
  end
end
