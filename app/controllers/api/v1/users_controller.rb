class Api::V1::UsersController < ApplicationController
  before_action :authorize_request, only: %i[show]

  def show
    if User.find_by(id: params[:id]) == @current_user
      render json: UserSerializer.new(@current_user).serialized_json, status: :ok
    else
      render json: { errors: 'User not found' }, status: :not_found
    end
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: UserSerializer.new(user).serialized_json, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
