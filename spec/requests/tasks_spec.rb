RSpec.describe Api::V1::TasksController, type: :request do
  let(:user) { create(:user) }
  let(:token) { JsonWebToken.encode(user_id: user.id) }
  let(:auth_params) { { 'Authorization' => token } }
  let(:new_description_for_task) { 'some new description' }
  let(:invalid_task_description) { 'a' * (Constants::TASK_DESCRIPTION_MIN_LENGTH - 1) }
  let(:project) { create(:project, user: user) }
  let(:task_valid_params) { attributes_for(:task, project_id: project.id) }
  let(:task_invalid_params) { attributes_for(:task, description: invalid_task_description, project_id: project.id) }

  describe 'GET #index' do
    let(:tasks_count) { 3 }

    it 'responds with success status' do
      get api_v1_project_tasks_path(project_id: project.id), headers: auth_params
      expect(response.status).to eq(200)
    end

    it 'renders actual tasks' do
      tasks_count.times do
        create(:task, project: project)
      end
      get api_v1_project_tasks_path(project_id: project.id), headers: auth_params
      expect(response).to match_response_schema('tasks')
      expect(response_json['data'].size).to eq(tasks_count)
    end
  end

  describe 'GET #show' do
    let(:task) { create(:task, project: project) }

    before do
      get api_v1_task_path(id: task.id), headers: auth_params
    end

    it 'responds with success status' do
      expect(response.status).to eq(200)
    end

    it 'renders actual task' do
      expect(response).to match_response_schema('task')
      expect(response_json['data']['attributes']['description']).to eq(task.description)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates new task' do
        expect do
          post api_v1_project_tasks_path(task_valid_params), headers: auth_params
        end.to change(Task, :count).by(1)
      end

      it do
        post api_v1_project_tasks_path(task_valid_params), headers: auth_params
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid params' do
      it 'does not create task' do
        expect do
          post api_v1_project_tasks_path(task_invalid_params), headers: auth_params
        end.not_to change(Task, :count)
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid params' do
      let(:task) { create(:task, project: project) }

      before do
        patch api_v1_task_path(id: task.id, description: new_description_for_task), headers: auth_params
      end

      it 'updates task' do
        task.reload
        expect(task.description).to eq new_description_for_task
      end

      it do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid params' do
      let(:task) { create(:task, project: project) }

      before do
        patch api_v1_task_path(id: task.id, description: invalid_task_description), headers: auth_params
      end

      it 'does not update task' do
        task.reload
        expect(task.description).not_to eq invalid_task_description
      end

      it do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:task) { create(:task, project: project) }

    it 'destroys task' do
      expect do
        delete api_v1_task_path(id: task.id), headers: auth_params
      end.to change(Task, :count).by(-1)
    end
  end
end
