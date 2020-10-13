class ApplicationController < ActionController::API
  include SimpleEndpoint::Controller

  private

  def authorize_request
    endpoint operation: Auth::Operation::AuthorizeRequest,
             options: { request: request }, different_handler: auth_handler
  end

  def default_cases
    {
      success: ->(result, **) { result.success? },
      invalid: ->(result, **) { result.failure? }
    }
  end

  def default_handler
    {
      success: ->(result, **) { render json: result['model'], **result['render_options'], status: :ok },
      invalid: ->(result, **) { render json: result['contract.default'].errors, status: :unprocessable_entity }
    }
  end

  def auth_handler
    {
      success: ->(result, **) { @current_user = result['user'] },
      invalid: ->(result, **) { render json: { errors: result['errors'] }, status: :unauthorized }
    }
  end

  def default_options
    { params: params, current_user: @current_user }
  end
end
