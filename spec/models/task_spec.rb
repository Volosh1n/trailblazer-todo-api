RSpec.describe Task, type: :model do
  describe 'Associations' do
    it { is_expected.to belong_to(:project) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:description) }

    it do
      is_expected.to validate_length_of(:description)
        .is_at_least(Task::DESCRIPTION_MIN_LENGTH).is_at_most(Task::DESCRIPTION_MAX_LENGTH)
    end
  end
end
