class Projects::Operation::Update < Trailblazer::Operation
  step :find_model
  step Contract::Build(constant: Projects::Contract::Default)
  step Contract::Validate()
  step Contract::Persist()
  step :serialize_project

  def find_model(ctx, params:, current_user:, **)
    ctx[:model] = current_user.projects.find_by(id: params[:id])
  end

  def serialize_project(ctx, model:, **)
    ctx[:serialized_project] = ProjectSerializer.new(model).serialized_json
  end
end
