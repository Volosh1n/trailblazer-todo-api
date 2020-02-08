# frozen_string_literal: true

RSpec.describe Users::Contract::Create do
  subject(:contract) { described_class.new(User.new) }

  describe 'validation' do
    context 'when valid params' do
      let(:valid_params) { attributes_for(:user) }

      it { expect(contract.validate(valid_params)).to be_truthy }
    end

    describe 'email field valaidation' do
      context 'without email' do
        let(:invalid_params) { attributes_for(:user, email: nil) }

        it { expect(contract.validate(invalid_params)).to be_falsey }
      end

      context 'with dublicate of email' do
        let(:some_email) { FFaker::Internet.email }
        let(:invalid_params) { attributes_for(:user, email: some_email) }

        before do
          create(:user, email: some_email)
        end

        it { expect(contract.validate(invalid_params)).to be_falsey }
      end

      context 'with invalid format of email' do
        let(:invalid_params) { attributes_for(:user, email: FFaker::Lorem.word) }

        it { expect(contract.validate(invalid_params)).to be_falsey }
      end
    end

    context 'with too short password' do
      let(:short_password) { 'a' * (Constants::PASSWORD_MIN_LENGTH - 1) }
      let(:invalid_params) { attributes_for(:user, password: short_password) }

      it { expect(contract.validate(invalid_params)).to be_falsey }
    end
  end
end
