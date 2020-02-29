# frozen_string_literal: true

RSpec.describe Projects::Operation::Update do
  subject(:result) do
    described_class.call(current_user: current_user, params: params)
  end

  let(:current_user) { create(:user) }

  context 'when valid params' do
    let(:new_name) { 'some new name' }
    let!(:project) { create(:project, user: current_user) }
    let(:params) { project.attributes.symbolize_keys!.merge(name: new_name) }

    it "updates user's project" do
      expect(result).to be_success
      expect(result[:model].name).to eq(new_name)
      expect(result[:model].user).to eq(current_user)
    end

    it 'returns serialized project' do
      expect { JSON.parse(result[:serialized_project]) }.not_to raise_error JSON::ParserError
    end
  end

  context 'when invalid params' do
    let!(:project) { create(:project, user: current_user) }
    let(:params) { project.attributes.merge(name: 'new_name') }

    it 'does not update project' do
      expect(result).to be_failure
    end
  end
end
