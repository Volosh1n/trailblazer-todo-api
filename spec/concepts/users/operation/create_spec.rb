# frozen_string_literal: true

RSpec.describe Users::Operation::Create do
  subject(:result) do
    described_class.call(params: params)
  end

  let(:email) { FFaker::Internet.email }
  let(:password) { FFaker::Lorem.words.join }
  let(:params) { { email: email, password: password } }

  context 'when valid params' do
    it 'creates user' do
      expect { result }.to change(User, :count).by(1)
      expect(result).to be_success
    end

    it 'returns serialized user' do
      expect { JSON.parse(result[:serialized_user]) }.not_to raise_error JSON::ParserError
    end
  end

  context 'when invalid params' do
    let(:email) { FFaker::Lorem.word }

    it 'does not create user' do
      expect { result }.not_to change(User, :count)
      expect(result).to be_failure
    end
  end
end
