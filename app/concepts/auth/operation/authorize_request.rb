class Auth::Operation::AuthorizeRequest < Trailblazer::Operation
  step :fetch_header
  fail :invalid_token
  step :decode_header
  fail :decode_fail
  step :find_user

  def fetch_header(ctx, request:, **)
    ctx[:header] = request.headers['Authorization']
  end

  def invalid_token(ctx, **)
    ctx[:errors] = 'Token is invalid'
  end

  def decode_header(ctx, header:, **)
    ctx[:decoded] = JsonWebToken.decode(header)
  end

  def decode_fail(ctx, **)
    ctx[:errors] = 'Token decode failed'
  end

  def find_user(ctx, decoded:, **)
    ctx[:user] = User.find_by(id: decoded[:user_id])
  end
end
