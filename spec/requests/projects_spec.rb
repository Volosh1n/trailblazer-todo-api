RSpec.describe Api::V1::ProjectsController, type: :request do
  let(:user) { create(:user) }
  let(:token) { JsonWebToken.encode(user_id: user.id) }
  let(:auth_params) { { 'Authorization' => token } }
  let(:new_name_for_project) { 'some new name' }
  let(:invalid_project_name) { 'a' * (Constants::PROJECT_NAME_MIN_LENGTH - 1) }
  let(:project_valid_params) { attributes_for(:project, user_id: user.id) }
  let(:project_invalid_params) { attributes_for(:project, name: invalid_project_name, user_id: user.id) }

  describe 'GET #index' do
    let(:projects_count) { 3 }

    it 'responds with success status' do
      get api_v1_projects_path(user_id: user.id), headers: auth_params
      expect(response.status).to eq(200)
    end

    it 'renders actual projects' do
      projects_count.times do
        create(:project, user: user)
      end
      get api_v1_projects_path(user_id: user.id), headers: auth_params
      expect(response_json['data'].size).to eq(projects_count)
    end
  end

  describe 'GET #show' do
    let(:project) { create(:project, user: user) }

    before do
      get api_v1_project_path(id: project.id), headers: auth_params
    end

    it 'responds with success status' do
      expect(response.status).to eq(200)
    end

    it 'renders actual project' do
      expect(response_json['data']['attributes']['name']).to eq(project.name)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates new user project' do
        expect do
          post api_v1_projects_path(project_valid_params), headers: auth_params
        end.to change(Project, :count).by(1)
      end

      it do
        post api_v1_projects_path(project_valid_params), headers: auth_params
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid params' do
      it 'does not create project' do
        expect do
          post api_v1_projects_path(project_invalid_params), headers: auth_params
        end.not_to change(Project, :count)
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid params' do
      let(:project) { create(:project, user: user) }

      before do
        patch api_v1_project_path(id: project.id, name: new_name_for_project), headers: auth_params
      end

      it 'updates user project' do
        project.reload
        expect(project.name).to eq new_name_for_project
      end

      it do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid params' do
      let(:project) { create(:project, user: user) }

      before do
        patch api_v1_project_path(id: project.id, name: invalid_project_name), headers: auth_params
      end

      it 'does not update project' do
        project.reload
        expect(project.name).not_to eq invalid_project_name
      end

      it do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:project) { create(:project, user: user) }

    it "destroys user's project" do
      expect do
        delete api_v1_project_path(id: project.id), headers: auth_params
      end.to change(Project, :count).by(-1)
    end
  end
end
