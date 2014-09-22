require 'http_errors'

module ErrorAction
  extend ActiveSupport::Concern

  def routing_error
    raise ActionController::RoutingError.new(params[:path])
  end

  def render_401(e = nil)
    logger.info(e.message) if e
    if request.xhr?
      render json: { error: '404 error' }, status: 401
    else
      render template: 'errors/error_404', status: 401
    end
  end

  def render_403(e = nil)
    render 'errors/error_403', status: 403
  end

  def render_404(e = nil)
    logger.info(e.message) if e
    if request.xhr?
      render json: { error: '404 error' }, status: 404
    else
      render template: 'errors/error_404', status: 404
    end
  end

  def render_500(e = nil)
    logger.info(e.message) if e
    if request.xhr?
      render json: { error: '500 error' }, status: 500
    else
      render template: 'errors/error_500', status: 500
    end
  end
end
