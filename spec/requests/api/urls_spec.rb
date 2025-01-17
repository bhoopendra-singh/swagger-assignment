require 'rails_helper'

RSpec.describe 'Api::UrlsController', type: :request do
  let(:valid_params) { { long_url: 'https://example.com' } }
  let(:invalid_params) { { long_url: 'invalid_url' } }
  let!(:auth_token) { AuthToken.create(token: SecureRandom.alphanumeric(16)) }
  let(:headers) { { 'Authorization' => "Bearer #{auth_token.token}", 'Content-Type' => 'application/json' } }

  describe 'POST /api/urls' do
    context 'with valid parameters' do
      it 'creates a new short URL' do
        post '/api/urls', headers: headers, params: valid_params.to_json
        expect(response).to have_http_status(:ok)
        body = JSON.parse(response.body)
        expect(body).to include('short_url')
      end
    end

    context 'with invalid parameters' do
      it 'returns an error for invalid URL format' do
        post '/api/urls', headers: headers, params: invalid_params.to_json
        expect(response).to have_http_status(:unprocessable_entity)
        body = JSON.parse(response.body)
        expect(body).to include('errors')
      end

      it 'returns an error if no long_url is provided' do
        post '/api/urls', headers: headers, params: {}.to_json
        expect(response).to have_http_status(:unprocessable_entity)
        body = JSON.parse(response.body)
        expect(body).to include('errors')
      end
    end
  end

  describe 'GET /api/urls/:id' do
    let!(:url) { Url.create!(long_url: 'https://example.com', short_url: 'abc123') }

    context 'when the short URL exists' do
      it 'returns the details of the short URL' do
        get "/api/urls/#{url.short_url}", headers: headers
        expect(response).to have_http_status(:ok)
        body = JSON.parse(response.body)
        expect(body).to include(
          'id' => url.id,
          'long_url' => url.long_url,
          'short_url' => url.short_url
        )
      end
    end

    context 'when the short URL does not exist' do
      it 'returns a not found error' do
        get '/api/urls/nonexistent', headers: headers
        expect(response).to have_http_status(:not_found)
        body = JSON.parse(response.body)
        expect(body).to include('error' => 'Short URL not found')
      end
    end
  end

  describe 'GET /api/get_token' do
    it 'retrieves the access token' do
      get '/api/get_token', headers: { 'Content-Type' => 'application/json' }
      expect(response).to have_http_status(:ok)
      body = JSON.parse(response.body)
      expect(body['token'].length).to eql(16)
    end
  end
end
