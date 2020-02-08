# frozen_string_literal: true

RSpec.describe Tasks::Contract::Default do
  subject(:contract) { described_class.new(Task.new) }

  describe 'validation' do
    context 'when valid params' do
      let(:valid_params) { attributes_for(:task) }

      it { expect(contract.validate(valid_params)).to be_truthy }
    end

    context 'when invalid params' do
      context 'without description' do
        let(:invalid_params) { attributes_for(:task, description: nil) }

        it { expect(contract.validate(invalid_params)).to be_falsey }
      end

      context 'with too short description' do
        let(:short_description) { 'a' * (Constants::TASK_DESCRIPTION_MIN_LENGTH - 1) }
        let(:invalid_params) { attributes_for(:task, description: short_description) }

        it { expect(contract.validate(invalid_params)).to be_falsey }
      end

      context 'with too long description' do
        let(:long_description) { 'a' * (Constants::TASK_DESCRIPTION_MAX_LENGTH + 1) }
        let(:invalid_params) { attributes_for(:task, description: long_description) }

        it { expect(contract.validate(invalid_params)).to be_falsey }
      end
    end
  end
end
