# frozen_string_literal: true

RSpec.describe Tasks::Operation::Create do
  subject(:result) do
    described_class.call(current_user: current_user, params: params)
  end

  let!(:project) { create(:project) }
  let(:current_user) { project.user }

  context 'when valid params' do
    let(:params) { attributes_for(:task).merge(project_id: project.id) }

    it "creates user's task" do
      expect { result }.to change(Task, :count).by(1)
      expect(result).to be_success
      expect(result[:model].project.user).to eq(current_user)
    end

    it 'returns serialized task' do
      expect { JSON.parse(result[:serialized_task]) }.not_to raise_error JSON::ParserError
    end
  end

  context 'when invalid params' do
    let(:params) { attributes_for(:task, name: nil) }

    it 'does not create task' do
      expect { result }.not_to change(Task, :count)
      expect(result).to be_failure
    end
  end
end
