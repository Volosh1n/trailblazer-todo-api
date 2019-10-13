class Api::V1::TasksController < ApplicationController
  before_action :authorize_request
  before_action :set_task, only: %i[show update destroy]

  def index
    render json: TaskSerializer.new(Task.all).serialized_json, status: :ok
  end

  def show
    render json: TaskSerializer.new(@task).serialized_json, status: :ok
  end

  def create
    task = @current_user.tasks.new(task_params)
    if task.save
      render json: TaskSerializer.new(task).serialized_json, status: :created
    else
      render json: { errors: task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @task.update(task_params)
      render json: TaskSerializer.new(@task).serialized_json, status: :ok
    else
      render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @task.destroy
      render json: TaskSerializer.new(@current_user.tasks).serialized_json, status: :ok
    else
      render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_task
    @task = @current_user.tasks.find_by(id: params[:id])
  end

  def task_params
    params.permit(:description, :project_id)
  end
end
