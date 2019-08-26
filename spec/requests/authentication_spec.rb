require 'rails_helper'

RSpec.describe AuthenticationController, type: :request do
  describe 'POST #login' do
    context 'when existing user' do
      let(:user_params) { attributes_for(:user) }
      let!(:user) { create(:user, email: user_params[:email], password: user_params[:password]) }

      it 'responds with success status' do
        post auth_login_path(user.attributes)
        expect(response).to have_http_status(:ok)
      end

      context 'with invalid id' do
        it 'responds with unauthorized status' do
          post auth_login_path(user.attributes.except('email'))
          expect(response).to have_http_status(:unauthorized)
        end
      end
    end
  end
end
