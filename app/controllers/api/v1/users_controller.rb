class Api::V1::UsersController < ApplicationController
  before_action :authorize_request, only: %i[show]

  def show
    endpoint operation: Users::Operation::Show, options: {
      params: params, current_user: @current_user
    }, different_handler: show_handler
  end

  def create
    endpoint operation: Users::Operation::Create, options: { params: params }, different_handler: create_handler
  end

  private

  def show_handler
    {
      success: ->(result, **) { render json: result['serialized_user'], status: :ok },
      invalid: ->(_, **) { render json: { errors: 'User not found' }, status: :not_found }
    }
  end

  def create_handler
    {
      success: ->(result, **) { render json: result['serialized_user'], status: :created },
      invalid: lambda { |result, **|
        render json: { errors: result['contract.default'].errors.full_messages }, status: :unprocessable_entity
      }
    }
  end
end
