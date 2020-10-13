class AuthenticationController < ApplicationController
  def login
    endpoint operation: Auth::Operation::Login, options: { params: params }, different_handler: login_handler
  end

  private

  def login_handler
    {
      success: ->(result, **) { render json: { token: result['token'], exp: result['time'] }, status: :ok },
      invalid: ->(_, **) { render json: { error: 'unauthorized' }, status: :unauthorized }
    }
  end
end
