require 'rails_helper'

RSpec.describe 'users API', type: :request do
  # Test suite for GET /users
  describe 'GET /users' do

    before :each do        
        @user = create(:user)
    end

    # make HTTP get request before each example
    before { get '/users', headers: auth_headers(@user) }

    it 'returns users' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(1)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /users/:username
  describe 'GET /users/:username' do
    context 'when the record exists' do

      before {
        @user = create(:user)
        get "/users/#{@user.username}", headers: auth_headers(@user)
      }

      it 'returns the user' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(@user.id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do

      before { 
        @user = create(:user)
        get "/users/not_found", headers: auth_headers(@user) 
      }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match("{\"errors\":\"User not found\"}")
      end
    end
  end

  # Test suite for POST /users
  describe 'POST /users' do
    # valid payload
    let(:valid_attributes) { { username: 'username', password: 'password' } }

    context 'when the request is valid' do
      before { 
        @user = create(:user)
        post '/users', params: valid_attributes, headers: auth_headers(@user)
      }

      it 'creates a user' do
        expect(json['username']).to eq('username')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { 
        @user = create(:user)
        post '/users', params: { username: 'foobar', password: 'a' } 
      }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match("{\"errors\":[\"Password is too short (minimum is 6 characters)\"]}")
      end
    end
  end

  # Test suite for PUT /users/:username
  describe 'PUT /users/:username' do
    let(:valid_attributes) { { username: Faker::Name.name } }

    context 'when the record exists' do
      before {
        @user = create(:user)
        put "/users/#{@user.username}", params: valid_attributes, headers: auth_headers(@user)
      }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /users/:username
  describe 'DELETE /users/:username' do
    
    before {
      @user = create(:user)
      delete "/users/#{@user.username}", headers: auth_headers(@user)
    }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end