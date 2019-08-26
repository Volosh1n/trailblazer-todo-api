class ApplicationController < ActionController::API
  def authorize_request
    header = request.headers['Authorization']
    decoded = JsonWebToken.decode(header)
    @current_user = User.find(decoded[:user_id])
  rescue ActiveRecord::RecordNotFound, JWT::DecodeError => e
    render json: { errors: e.message }, status: :unauthorized
  end
end
