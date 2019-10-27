class Users::Operation::Show < Trailblazer::Operation
  step :find_model

  def find_model(ctx, params:, current_user:, **)
    ctx[:model] = User.find_by(id: params[:id]) == current_user
  end
end
