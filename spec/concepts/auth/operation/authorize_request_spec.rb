# frozen_string_literal: true

RSpec.describe Auth::Operation::AuthorizeRequest do
  subject(:result) do
    described_class.call(request: request)
  end

  let(:headers) { { 'Authorization' => 'some stub' } }
  let(:request) { double('Request', headers: headers) } # rubocop:disable RSpec/VerifiedDoubles
  let(:user) { create(:user) }
  let(:decoded) { { user_id: user.id } }

  before do
    allow(request).to receive(:headers).and_return(headers)
    allow(JsonWebToken).to receive(:decode).and_return(decoded)
  end

  describe 'success' do
    it 'sets user' do
      expect(result).to be_success
      expect(result[:user]).to eq(user)
    end
  end

  describe 'failure' do
    let(:decoded) { { user_id: 322 } }

    it 'sets user' do
      expect(result).to be_failure
      expect(result[:user]).to be_nil
    end
  end
end
