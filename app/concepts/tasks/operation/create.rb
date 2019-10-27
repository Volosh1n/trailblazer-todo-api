class Tasks::Operation::Create < Trailblazer::Operation
  step :build_model
  step Contract::Build(constant: Tasks::Contract::Default)
  step Contract::Validate()
  step Contract::Persist()

  def build_model(ctx, current_user:, **)
    ctx[:model] = current_user.tasks.new
  end
end
