# frozen_string_literal: true

RSpec.describe Auth::Operation::Login do
  subject(:result) do
    described_class.call(params: params)
  end

  let(:user) { create(:user) }
  let(:email) { user.email }
  let(:params) { { email: email } }

  describe 'success' do
    it 'sets user' do
      expect(result).to be_success
      expect(result[:user]).to eq(user)
      expect(result[:token]).to eq(JsonWebToken.encode(user_id: user.id))
      expect(result[:time]).to eq((Time.zone.now + 24.hours.to_i).strftime('%m-%d-%Y %H:%M'))
    end
  end

  describe 'failure' do
    let(:random_email) { FFaker::Internet.email }
    let(:params) { { email: random_email } }

    it 'sets user' do
      expect(result).to be_failure
      expect(result[:user]).to be_nil
    end
  end
end
