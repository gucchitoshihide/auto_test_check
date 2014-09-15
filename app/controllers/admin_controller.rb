class AdminController < ApplicationController
  before_filter :basic_auth, only: [:login]

  def index
  end

  def login
  end

  def create
    begin
      Admin.authenticate(admin_params)
    rescue ValidationError, AuthorizationError => e
      flash.now[:alert] = Flash.format_error_message(e.message)
      return(render 'login')
    end
    redirect_to admin_index_path
  end

  private

  def basic_auth
    authenticate_or_request_with_http_basic do |id, password|
      id == Settings[:admin][:basic_auth][:id] and password == Settings[:admin][:basic_auth][:password]
    end
  end

  def admin_params
    params.require(:admin).permit(Settings[:admin][:allowed_keys])
  end
end
