class AuthenticationController < ApplicationController
  before_action :authorize_request, except: :login

  def login
    user = User.find_by(email: params[:email])
    return render json: { error: 'unauthorized' }, status: :unauthorized unless user

    token = JsonWebToken.encode(user_id: user.id)
    time = (Time.now + 24.hours.to_i).strftime('%m-%d-%Y %H:%M')
    render json: { token: token, exp: time }, status: :ok
  end
end
