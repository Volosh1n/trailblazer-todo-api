class Api::V1::TasksController < ApplicationController
  before_action :authorize_request

  def index
    render json: TaskSerializer.new(@current_user.tasks.all).serialized_json, status: :ok
  end

  def show
    endpoint operation: Tasks::Operation::Show, options: {
      params: params, current_user: @current_user
    }, different_handler: show_handler
  end

  # def create
  #   task = @current_user.tasks.new(task_params)
  #   if task.save
  #     render json: TaskSerializer.new(task).serialized_json, status: :created
  #   else
  #     render json: { errors: task.errors.full_messages }, status: :unprocessable_entity
  #   end
  # end

  # def update
  #   if @task.update(task_params)
  #     render json: TaskSerializer.new(@task).serialized_json, status: :ok
  #   else
  #     render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
  #   end
  # end

  # def destroy
  #   if @task.destroy
  #     render json: TaskSerializer.new(@current_user.tasks).serialized_json, status: :ok
  #   else
  #     render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
  #   end
  # end

  def create
    endpoint operation: Tasks::Operation::Create, options: {
      params: params, current_user: @current_user
    }
  end

  def update
    endpoint operation: Tasks::Operation::Update, options: {
      params: params, current_user: @current_user
    }
  end

  def destroy
    endpoint operation: Tasks::Operation::Destroy, options: {
      params: params, current_user: @current_user
    }
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
