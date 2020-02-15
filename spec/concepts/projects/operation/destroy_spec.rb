# frozen_string_literal: true

RSpec.describe Projects::Operation::Destroy do
  subject(:result) do
    described_class.call(current_user: current_user, params: params)
  end

  let!(:current_user) { create(:user) }

  context 'when valid params' do
    let!(:project) { create(:project, user: current_user) }
    let(:params) { project.attributes.symbolize_keys! }

    it 'destroys project' do
      expect { result }.to change(Project, :count).by(-1)
      expect(result).to be_success
    end
  end

  context 'when invalid params' do
    let!(:project) { create(:project, user: current_user) }
    let(:params) { project.attributes }

    it 'does not destroy project' do
      expect { result }.not_to change(Project, :count)
      expect(result).to be_failure
    end
  end
end
