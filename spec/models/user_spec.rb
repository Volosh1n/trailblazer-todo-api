RSpec.describe User, type: :model do
  let(:valid_email) { 'email@example.com' }

  it { is_expected.to validate_uniqueness_of(:email) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to allow_value(valid_email).for(:email) }
  it { is_expected.to validate_length_of(:password).is_at_least(User::PASSWORD_MIN_LENGTH) }
  it { is_expected.to have_many(:projects).dependent(:destroy) }
end
