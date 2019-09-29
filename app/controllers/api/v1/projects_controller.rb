class Api::V1::ProjectsController < ApplicationController
  before_action :authorize_request
  before_action :set_project, only: %i[show update destroy]

  def index
    render json: ProjectSerializer.new(Project.all).serialized_json, status: :ok
  end

  def show
    render json: ProjectSerializer.new(@project).serialized_json, status: :ok
  end

  def create
    project = @current_user.projects.new(project_params)
    if project.save
      render json: ProjectSerializer.new(project).serialized_json, status: :created
    else
      render json: { errors: project.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @project.update(project_params)
      render json: ProjectSerializer.new(@project).serialized_json, status: :ok
    else
      render json: { errors: @project.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @project.destroy
      render json: ProjectSerializer.new(@current_user.projects).serialized_json, status: :ok
    else
      render json: { errors: @project.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_project
    @project = @current_user.projects.find_by(id: params[:id])
  end

  def project_params
    params.permit(:name, :user_id)
  end
end
