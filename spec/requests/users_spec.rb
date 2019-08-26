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
        expect(response).to be_ok
      end
    end

    context 'when authorized request' do
      let(:token) { nil }

      it 'responds with unauthorized status' do
        expect(response).to be_unauthorized
      end
    end
  end

  describe 'POST #create' do
    let(:user_params) { attributes_for(:user) }
    let(:user_invalid_params) { attributes_for(:user, email: 'email') }

    context 'with valid params' do
      it 'creates new user' do
        expect { post api_v1_users_path(user_params) }.to change(User, :count).by(1)
      end
    end

    context 'with invalid params' do
      it 'does not create user' do
        expect { post api_v1_users_path(user_invalid_params) }.not_to change(User, :count)
      end
    end
  end
end
