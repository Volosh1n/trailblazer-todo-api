# frozen_string_literal: true

RSpec.describe Tasks::Operation::Update do
  subject(:result) do
    described_class.call(current_user: current_user, params: params)
  end

  let!(:task) { create(:task) }
  let(:project) { task.project }
  let(:current_user) { project.user }

  context 'when valid params' do
    let(:new_description) { 'some new description' }
    let(:params) { task.attributes.symbolize_keys!.merge(description: new_description) }

    it "updates user's task" do
      expect(result).to be_success
      expect(result[:model].description).to eq(new_description)
      expect(result[:model].project.user).to eq(current_user)
    end

    it 'returns serialized task' do
      expect { JSON.parse(result[:serialized_task]) }.not_to raise_error JSON::ParserError
    end
  end

  context 'when invalid params' do
    let(:params) { project.attributes.merge(description: 'new_description') }

    it 'does not update project' do
      expect(result).to be_failure
    end
  end
end
