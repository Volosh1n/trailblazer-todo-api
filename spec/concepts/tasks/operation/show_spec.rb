# frozen_string_literal: true

RSpec.describe Tasks::Operation::Show do
  subject(:result) do
    described_class.call(current_user: current_user, params: params)
  end

  let!(:task) { create(:task) }
  let(:project) { task.project }
  let(:current_user) { project.user }

  context 'when valid params' do
    let(:params) { task.attributes.symbolize_keys! }

    it 'returns serialized task' do
      expect { JSON.parse(result[:serialized_task]) }.not_to raise_error JSON::ParserError
      expect(result).to be_success
    end
  end

  context 'when invalid params' do
    let(:params) { task.attributes }

    it 'does not return task' do
      expect(result).to be_failure
    end
  end
end
