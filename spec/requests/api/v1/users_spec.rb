require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'POST /api/v1/signup' do
    let!(:username) { Faker::Internet.username(specifier: 10) }
    let!(:email) { Faker::Internet.email }
    let!(:valid_params) { { user: { username: username, email: email, password: 'password' } } }

    it 'creates a new user' do
      post '/api/v1/signup', params: valid_params

      expect(response).to have_http_status(:ok)
      expect(User.count).to eq(1)
      expect(User.first.email).to eq(email)
    end

    it 'returns an error with invalid parameters' do
      invalid_params = valid_params.merge(user: { username: '', email: '', password: '' })

      post '/api/v1/signup', params: invalid_params

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'GET /api/v1/users/:id' do
    let!(:user) { create(:user) }

    it 'returns the user details' do
      get "/api/v1/users/#{user.hashid}"

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['data']['email']).to eq(user.email)
    end

    it 'returns an error for non-existent user' do
      get "/api/v1/users/nonexistent-id"

      expect(response).to have_http_status(:not_found)
    end
  end
end