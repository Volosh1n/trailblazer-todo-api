class Auth::Operation::Login < Trailblazer::Operation
  step :find_user
  step :encode_token
  step :set_expiration_date

  def find_user(ctx, params:, **)
    ctx[:user] = User.find_by(email: params[:email])
  end

  def encode_token(ctx, user:, **)
    ctx[:token] = JsonWebToken.encode(user_id: user.id)
  end

  def set_expiration_date(ctx, **)
    ctx[:time] = (Time.zone.now + 24.hours.to_i).strftime('%m-%d-%Y %H:%M')
  end
end
