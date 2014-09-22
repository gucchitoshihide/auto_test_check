class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include ErrorAction

#  rescue_from Exception,                      with: :render_500
#  rescue_from ActiveRecord::RecordNotFound,   with: :render_500
  rescue_from Unauthorization,                with: :render_401
  rescue_from ActionController::RoutingError, with: :render_404
  rescue_from Forbidden,                      with: :render_403

  private

  # http://ja.asciicasts.com/episodes/270-authentication-in-rails-3-1
  def current_user
    @current_user ||= User.find(session[:id]) if session[:id]
  end

  # http://stackoverflow.com/questions/5000333/how-does-rails-csrf-protection-work
  # http://www.adamjonas.com/blog/rails-4-csrf-handling/
  def handle_unverified_request
    render_401
  end

  helper_method :current_user
end
