class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include ErrorAction

#  rescue_from Exception,                      with: :render_500
#  rescue_from ActiveRecord::RecordNotFound,   with: :render_500
  rescue_from ActionController::RoutingError, with: :render_404
  rescue_from Forbidden,                      with: :render_403

  private

  # http://ja.asciicasts.com/episodes/270-authentication-in-rails-3-1
  def current_user
    @current_user ||= User.find(session[:id]) if session[:id]
  end

  helper_method :current_user
end
