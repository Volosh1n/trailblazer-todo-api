class Api::V1::TasksController < ApplicationController
  before_action :authorize_request

  def index
    render json: TaskSerializer.new(@current_user.tasks.all).serialized_json, status: :ok
  end

  def show
    endpoint operation: Tasks::Operation::Show, options: default_options, different_handler: show_handler
  end

  def create
    endpoint operation: Tasks::Operation::Create, options: default_options
  end

  def update
    endpoint operation: Tasks::Operation::Update, options: default_options
  end

  def destroy
    endpoint operation: Tasks::Operation::Destroy, options: default_options
  end

  private

  def show_handler
    {
      success: ->(result) { render json: TaskSerializer.new(result['model']).serialized_json, status: :ok },
      invalid: ->(_) { render json: { errors: 'Task not found' }, status: :not_found }
    }
  end

  def default_handler
    {
      success: ->(result) { render json: TaskSerializer.new(result['model']).serialized_json, status: :ok },
      invalid: lambda { |result|
        render json: { errors: result['contract.default'].errors.full_messages }, status: :unprocessable_entity
      }
    }
  end
end
