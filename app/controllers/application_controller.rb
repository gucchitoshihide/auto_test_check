class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include ErrorAction

  rescue_from Exception,                      with: :render_500
  rescue_from ActiveRecord::RecordNotFound,   with: :render_500
  rescue_from ActionController::RoutingError, with: :render_404
  rescue_from Forbidden,                      with: :render_403
end
