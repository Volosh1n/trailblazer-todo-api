class Projects::Operation::Destroy < Trailblazer::Operation
  step :find_model
  step :destroy_model

  def find_model(ctx, params:, current_user:, **)
    ctx[:model] = current_user.projects.find_by(id: params[:id])
  end

  def destroy_model(ctx, model:, **)
    ctx[:model].destroy
  end
end
