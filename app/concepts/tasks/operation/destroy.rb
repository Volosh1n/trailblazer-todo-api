class Tasks::Operation::Destroy < Trailblazer::Operation
  step :find_model
  step :destroy_model

  def find_model(ctx, params:, current_user:, **)
    ctx[:model] = current_user.tasks.find_by(id: params[:id])
  end

  def destroy_model(_ctx, model:, **)
    model.destroy
  end
end
