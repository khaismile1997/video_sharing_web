require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  describe 'POST /api/v1/login' do
    let!(:user) { create(:user, password: 'password') }

    it 'logs in a user with valid credentials' do
      post '/api/v1/login', params: { session: { email: user.email, password: 'password' } }

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['data']['email']).to eq(user.email)
    end

    it 'returns an error with invalid credentials' do
      post '/api/v1/login', params: { session: { email: user.email, password: 'wrong_password' } }

      expect(response).to have_http_status(:unauthorized)
      expect(JSON.parse(response.body)['error']['message']).to eq(I18n.t("api_error.invalid_login"))
    end
  end

  describe 'DELETE /api/v1/logout' do
    context 'when logout a user' do
      include_context "when user has signed in"
    
      it 'logout success' do
        delete '/api/v1/logout'

        expect(response).to have_http_status(:ok)
        expect(response.body).to include(I18n.t('messages.success.logout'))
      end
    end

    it 'returns an error without valid token' do
      delete '/api/v1/logout'

      expect(response).to have_http_status(:unauthorized)
      expect(JSON.parse(response.body)['error']['message']).to eq(I18n.t("api_error.invalid_logout"))
    end
  end
end