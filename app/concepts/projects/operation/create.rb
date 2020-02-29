class Projects::Operation::Create < Trailblazer::Operation
  step :build_model
  step Contract::Build(constant: Projects::Contract::Default)
  step Contract::Validate()
  step Contract::Persist()
  step :serialize_project

  def build_model(ctx, current_user:, **)
    ctx[:model] = current_user.projects.new
  end

  def serialize_project(ctx, model:, **)
    ctx[:serialized_project] = ProjectSerializer.new(model).serialized_json
  end
end
