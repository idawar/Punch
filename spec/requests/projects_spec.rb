require 'rails_helper'

RSpec.describe 'Projects API', type: :request do
  let!(:projects) { create_list(:project, 3) }
  let(:project_id) { projects.first.id }
  let(:auth_headers) {{ 
    "Authorization" => "Token " + SecureRandom.hex(10),
    "Content-Type" => "application/json",
  }}

  describe 'GET projects' do
    before { get '/projects.json', params: nil, headers: auth_headers }

    it 'returns projects' do
      expect(json).not_to be_empty
      expect(json.size).to eq(3)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET projects/:id' do
    before { get "/projects/#{project_id}.json", params: nil, headers: auth_headers  }

    context 'when the record exists' do
      it 'returns the project' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(project_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:project_id) { 1100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Not Found/)
      end
    end
  end

  describe 'POST project' do
    let(:valid_attributes) { {project: { name: 'Project Punch' }} }

    context 'when the request is valid' do
      before { post '/projects.json', params: valid_attributes.to_json, headers: auth_headers }

      it 'creates a project' do
        expect(json['name']).to eq('Project Punch')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the request is not authorized' do
      before { post '/projects.json', params: { name: 'Project Punch' } }

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end
    end
  end

  describe 'PUT projects/:id' do
    let(:valid_attributes) { {project: { name: 'New Project Punch' }} }

    context 'when the record exists' do
      before { put "/projects/#{project_id}.json", params: valid_attributes.to_json, headers: auth_headers }

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

end