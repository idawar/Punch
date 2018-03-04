require 'rails_helper'

RSpec.describe 'Clients API', type: :request do
  let!(:clients) { create_list(:user, 10, :client) }
  let(:client_id) { clients.first.id }
  let(:auth_headers) {{ 
    "Authorization" => "Token " + SecureRandom.hex(10),
    "Content-Type" => "application/json",
  }}

  describe 'GET clients' do
    before { get '/clients.json', params: nil, headers: auth_headers }

    it 'returns clients' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET clients/:id' do
    before { get "/clients/#{client_id}.json", params: nil, headers: auth_headers }

    context 'when the record exists' do
      it 'returns the client' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(client_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:client_id) { 1100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Not Found/)
      end
    end
  end

  describe 'POST client' do
    let(:valid_attributes) { {"client"=> { "name"=> 'Leo Lee', "email"=> "leo@punch.com" }} }

    context 'when the request is valid' do
      before { post '/clients.json', params: valid_attributes.to_json, headers: auth_headers }

      it 'creates a client' do
        expect(json['name']).to eq('Leo Lee')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the request is invalid' do
      before { post '/clients.json', 
        params: { "client" => { name: 'Leo Lee' }}.to_json, headers: auth_headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Email can't be blank/)
      end
    end
  end

  describe 'PUT clients/:id' do
    let(:valid_attributes) { { name: 'Lee Lee' } }

    context 'when the record exists' do
      before { put "/clients/#{client_id}.json", params: valid_attributes.to_json, headers: auth_headers }

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

end