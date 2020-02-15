# frozen_string_literal: true

RSpec.describe Tasks::Operation::Destroy do
  subject(:result) do
    described_class.call(current_user: current_user, params: params)
  end

  let!(:task) { create(:task) }
  let(:project) { task.project }
  let(:current_user) { project.user }

  context 'when valid params' do
    let(:params) { task.attributes.symbolize_keys! }

    it 'destroys task' do
      expect { result }.to change(Task, :count).by(-1)
      expect(result).to be_success
    end
  end

  context 'when invalid params' do
    let(:params) { task.attributes }

    it 'does not destroy task' do
      expect { result }.not_to change(Task, :count)
      expect(result).to be_failure
    end
  end
end
