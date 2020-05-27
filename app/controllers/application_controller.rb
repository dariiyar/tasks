class ApplicationController < ActionController::API
  def render_404
    render json: { errors: ['Not found'] }, status: :not_found
  end
end
