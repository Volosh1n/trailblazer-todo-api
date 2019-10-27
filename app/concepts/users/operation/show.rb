class Users::Operation::Show < Trailblazer::Operation
  step :find_user

  def find_user(_ctx, params:, current_user:, **)
    User.find_by(id: params[:id]) == current_user
  end
end
