RSpec.describe Project, type: :model do
  describe 'Associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:tasks).dependent(:destroy) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:name) }

    it do
      is_expected.to validate_length_of(:name)
        .is_at_least(Project::NAME_MIN_LENGTH).is_at_most(Project::NAME_MAX_LENGTH)
    end
  end
end
