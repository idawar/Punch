require 'rails_helper'

RSpec.describe 'Employees API', type: :request do
  let!(:employees) { create_list(:user, 10, :employee) }
  let(:employee_id) { employees.first.id }
  let(:auth_headers) {{ 
    "Authorization" => "Token " + SecureRandom.hex(10),
    "Content-Type" => "application/json",
  }}

  describe 'GET employees' do
    before { get '/employees.json', params: nil, headers: auth_headers }

    it 'returns employees' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET employees/:id' do
    before { get "/employees/#{employee_id}.json", params: nil, headers: auth_headers }

    context 'when the record exists' do
      it 'returns the employee' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(employee_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:employee_id) { 1100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Not Found/)
      end
    end
  end

  describe 'POST employee' do
    let(:valid_attributes) { {"employee"=> { "name"=> 'Leo Lee', "email"=> "leo@punch.com" }} }

    context 'when the request is valid' do
      before { post '/employees.json', params: valid_attributes.to_json, headers: auth_headers }

      it 'creates a employee' do
        expect(json['name']).to eq('Leo Lee')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the request is invalid' do
      before { post '/employees.json', 
        params: { "employee" => { name: 'Leo Lee' }}.to_json, headers: auth_headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Email can't be blank/)
      end
    end
  end

  describe 'PUT employees/:id' do
    let(:valid_attributes) { { name: 'Lee Lee' } }

    context 'when the record exists' do
      before { put "/employees/#{employee_id}.json", params: valid_attributes.to_json, headers: auth_headers }

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

end