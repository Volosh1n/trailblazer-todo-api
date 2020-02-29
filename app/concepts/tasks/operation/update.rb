class Tasks::Operation::Update < Trailblazer::Operation
  step :find_model
  step Contract::Build(constant: Tasks::Contract::Default)
  step Contract::Validate()
  step Contract::Persist()
  step :serialize_task

  def find_model(ctx, params:, current_user:, **)
    ctx[:model] = current_user.tasks.find_by(id: params[:id])
  end

  def serialize_task(ctx, model:, **)
    ctx[:serialized_task] = TaskSerializer.new(model).serialized_json
  end
end
