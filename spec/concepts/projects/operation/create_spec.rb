# frozen_string_literal: true

RSpec.describe Projects::Operation::Create do
  subject(:result) do
    described_class.call(current_user: current_user, params: params)
  end

  let(:current_user) { create(:user) }

  context 'when valid params' do
    let(:params) { attributes_for(:project) }

    it "creates user's project" do
      expect { result }.to change(Project, :count).by(1)
      expect(result).to be_success
      expect(result[:model].user).to eq(current_user)
    end

    it 'returns serialized project' do
      expect { JSON.parse(result[:serialized_project]) }.not_to raise_error JSON::ParserError
    end
  end

  context 'when invalid params' do
    let(:params) { attributes_for(:project, name: nil) }

    it 'does not create project' do
      expect { result }.not_to change(Project, :count)
      expect(result).to be_failure
    end
  end
end
