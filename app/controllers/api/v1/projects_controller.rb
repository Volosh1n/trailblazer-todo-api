class Api::V1::ProjectsController < ApplicationController
  before_action :authorize_request

  def index
    render json: ProjectSerializer.new(@current_user.projects).serialized_json, status: :ok
  end

  def show
    endpoint operation: Projects::Operation::Show, options: default_options, different_handler: show_handler
  end

  def create
    endpoint operation: Projects::Operation::Create, options: default_options
  end

  def update
    endpoint operation: Projects::Operation::Update, options: default_options
  end

  def destroy
    endpoint operation: Projects::Operation::Destroy, options: default_options
  end

  private

  def show_handler
    {
      success: ->(result, **) { render json: result['serialized_project'], status: :ok },
      invalid: ->(_, **) { render json: { errors: 'Project not found' }, status: :not_found }
    }
  end

  def default_handler
    {
      success: ->(result, **) { render json: result['serialized_project'], status: :ok },
      invalid: lambda { |result, **|
        render json: { errors: result['contract.default'].errors.full_messages }, status: :unprocessable_entity
      }
    }
  end
end
