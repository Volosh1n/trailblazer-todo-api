class Api::V1::UsersController < ApplicationController
  before_action :find_user, only: %i[show]
  before_action :authorize_request, only: %i[show]

  def show
    render json: @user, status: :ok
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def find_user
    @user = User.find_by!(id: params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'User not found' }, status: :not_found
  end

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
