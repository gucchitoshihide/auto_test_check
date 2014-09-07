class ResetPasswordsController < ApplicationController
  before_action :back_to_root,    only: [:new]
  before_action :edit_forbidden,  only: [:edit]
  before_action :render_fobidden, only: [:announce, :finish]

  def new
  end

  def create
    begin
      User.request_reset_password(params)
      flash.now[:notice] = I18n.t('las.reset_password.message.notice.send_email')
      render 'announce'
    rescue ValidationError => e
      flash.now[:alert] = User.format_error_message(e.message)
      render 'new'
    end
  end

  def edit
    begin
      # use at form
      User.certificate(params[:format])
    rescue ActiveRecord::RecordNotFound, CertificationError => e
      flash.now[:alert] = [I18n.t('las.reset_password.message.alert.certification')]
      render 'announce'
    end
  end

  def update
    begin
      User.reset_password(params[:format], reset_password_params)
      ResetPassword.reset_token(params[:format])
      flash.now[:notice] = I18n.t('las.reset_password.message.notice.success_update')
      render 'finish'
    rescue ValidationError => e
      flash.now[:alert] = User.format_error_message(e.message)
      render 'edit'
    end
  end

  def announce
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

  def edit_forbidden
    raise Forbidden if params[:format].blank?
  end

  def render_fobidden
    raise Forbidden if request
  end

end
