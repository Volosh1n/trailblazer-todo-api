require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :request do
  describe 'GET #show' do
    let(:user) { create(:user) }
    let(:token) { JsonWebToken.encode(user_id: user.id) }

    before do
      get api_v1_user_path(id: user.id), headers: { 'Authorization' => token }
    end

    context 'when authorized request' do
      it 'responds with success status' do
        expect(response).to have_http_status(:ok)
      end

      context 'with invalid id' do
        it do
          get api_v1_user_path(id: (user.id + 1)), headers: { 'Authorization' => token }
          expect(response).to have_http_status(:not_found)
        end
      end
    end

    context 'when authorized request' do
      let(:token) { nil }

      it 'responds with unauthorized status' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'POST #create' do
    let(:user_params) { attributes_for(:user) }
    let(:user_invalid_params) { attributes_for(:user, email: 'email') }

    context 'with valid params' do
      it 'creates new user' do
        expect { post api_v1_users_path(user_params) }.to change(User, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid params' do
      it 'does not create user' do
        expect { post api_v1_users_path(user_invalid_params) }.not_to change(User, :count)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
