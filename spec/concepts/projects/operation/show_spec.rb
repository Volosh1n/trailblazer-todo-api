# frozen_string_literal: true

RSpec.describe Projects::Operation::Show do
  subject(:result) do
    described_class.call(current_user: current_user, params: params)
  end

  let!(:current_user) { create(:user) }

  context 'when valid params' do
    let!(:project) { create(:project, user: current_user) }
    let(:params) { project.attributes.symbolize_keys! }

    it 'returns serialized project' do
      expect { JSON.parse(result[:serialized_project]) }.not_to raise_error JSON::ParserError
      expect(result).to be_success
    end
  end

  context 'when invalid params' do
    let!(:project) { create(:project, user: current_user) }
    let(:params) { project.attributes }

    it 'does not return project' do
      expect(result).to be_failure
    end
  end
end
