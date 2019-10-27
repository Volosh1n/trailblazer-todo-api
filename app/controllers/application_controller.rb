class ApplicationController < ActionController::API
  include SimpleEndpoint::Controller

  private

  def authorize_request
    header = request.headers['Authorization']
    decoded = JsonWebToken.decode(header)
    @current_user = User.find(decoded[:user_id])
  rescue ActiveRecord::RecordNotFound, JWT::DecodeError => e
    render json: { errors: e.message }, status: :unauthorized
  end

  def default_cases
    {
      success: ->(result) { result.success? },
      invalid: ->(result) { result.failure? }
    }
  end

  def default_handler
    {
      success: ->(result) { render json: result['model'], **result['render_options'], status: :ok },
      invalid: ->(result) { render json: result['contract.default'].errors, status: :unprocessable_entity }
    }
  end
end
