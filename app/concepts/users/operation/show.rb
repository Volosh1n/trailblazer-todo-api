class Users::Operation::Show < Trailblazer::Operation
  step :find_model
  step :serialize_user

  def find_model(ctx, params:, **)
    ctx[:model] = User.find_by(id: params[:id])
  end

  def serialize_user(ctx, model:, **)
    ctx[:serialized_user] = UserSerializer.new(model).serialized_json
  end
end
