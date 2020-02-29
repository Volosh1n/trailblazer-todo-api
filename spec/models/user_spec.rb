RSpec.describe User, type: :model do
  it { is_expected.to have_many(:projects).dependent(:destroy) }
end
