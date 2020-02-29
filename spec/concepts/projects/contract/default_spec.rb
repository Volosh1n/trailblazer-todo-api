# frozen_string_literal: true

RSpec.describe Projects::Contract::Default do
  subject(:contract) { described_class.new(Project.new) }

  describe 'validation' do
    context 'when valid params' do
      let(:valid_params) { attributes_for(:project) }

      it { expect(contract.validate(valid_params)).to be_truthy }
    end

    context 'when invalid params' do
      context 'without name' do
        let(:invalid_params) { attributes_for(:project, name: nil) }

        it { expect(contract.validate(invalid_params)).to be_falsey }
      end

      context 'with too short name' do
        let(:short_name) { 'a' * (Constants::PROJECT_NAME_MIN_LENGTH - 1) }
        let(:invalid_params) { attributes_for(:project, name: short_name) }

        it { expect(contract.validate(invalid_params)).to be_falsey }
      end

      context 'with too long name' do
        let(:long_name) { 'a' * (Constants::PROJECT_NAME_MAX_LENGTH + 1) }
        let(:invalid_params) { attributes_for(:project, name: long_name) }

        it { expect(contract.validate(invalid_params)).to be_falsey }
      end
    end
  end
end
