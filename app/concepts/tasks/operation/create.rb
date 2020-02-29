class Tasks::Operation::Create < Trailblazer::Operation
  step :build_model
  step Contract::Build(constant: Tasks::Contract::Default)
  step Contract::Validate()
  step Contract::Persist()
  step :serialize_task

  def build_model(ctx, current_user:, **)
    # binding.pry
    ctx[:model] = current_user.tasks.new
  end

  def serialize_task(ctx, model:, **)
    ctx[:serialized_task] = TaskSerializer.new(model).serialized_json
  end
end
