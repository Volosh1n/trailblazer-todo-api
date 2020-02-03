class Tasks::Operation::Show < Trailblazer::Operation
  step :find_model
  step :serialize_task

  def find_model(ctx, params:, current_user:, **)
    ctx[:model] = current_user.tasks.find_by(id: params[:id])
  end

  def serialize_task(ctx, model:, **)
    ctx[:serialized_task] = TaskSerializer.new(model).serialized_json
  end
end
