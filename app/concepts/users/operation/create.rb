class Users::Operation::Create < Trailblazer::Operation
  step Model(User, :new)
  step Contract::Build(constant: Users::Contract::Create)
  step Contract::Validate()
  step Contract::Persist()
  step :serialize_user

  def serialize_user(ctx, model:, **)
    ctx[:serialized_user] = UserSerializer.new(model).serialized_json
  end
end
