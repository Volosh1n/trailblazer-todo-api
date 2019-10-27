class Tasks::Operation::Update < Trailblazer::Operation
  step :find_model
  step Contract::Build(constant: Tasks::Contract::Default)
  step Contract::Validate()
  step Contract::Persist()

  def find_model(ctx, params:, current_user:, **)
    ctx[:model] = current_user.tasks.find_by(id: params[:id])
  end
end
