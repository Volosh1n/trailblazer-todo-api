class Users::Operation::Show < Trailblazer::Operation
  step :find_model
  step :serialize

  def find_model(ctx, params:, current_user:, **)
    ctx[:model] = User.find_by(id: params[:id]) == current_user
  end

  def serialize(ctx, model:, **)
    ctx[:serialized_user] = UserSerializer.new(model).serialized_json
  end
end
