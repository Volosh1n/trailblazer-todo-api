class Auth::Operation::AuthorizeRequest < Trailblazer::Operation
  step :fetch_header
  step :decode_header
  step :find_user

  def fetch_header(ctx, request:, **)
    ctx[:header] = request.headers['Authorization']
  end

  def decode_header(ctx, header:, **)
    ctx[:decoded] = JsonWebToken.decode(header)
  end

  def find_user(ctx, decoded:, **)
    ctx[:user] = User.find(decoded[:user_id])
  end
end
