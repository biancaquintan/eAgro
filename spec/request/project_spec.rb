require 'rails_helper'

RSpec.describe 'projects API', type: :request do
  describe "GET /api/v1/projects" do
    it 'returns success status' do
        get api_v1_projects_path
        expect(response).to have_http_status(200)
    end
    it "the project's name is present" do
        projects = create_list(:project, 3)
        get api_v1_projects_path
        projects.each do |project|
            expect(response.body).to include(project.name)
        end
    end
  end

  describe "POST /api/v1/projects" do
    context 'when it has valid parameters' do
        it 'creates the project with correct attributes' do
            project_attributes = FactoryBot.attributes_for(:project)
            post api_v1_projects_path, params: { project: project_attributes }
            expect(Project.last).to have_attributes(project_attributes)
        end
    end

    context 'when it has no valid parameters' do
        it 'does not create project' do
            expect{
                post api_v1_projects_path, params: { project: {name: ''} }
            }.to_not change(Project, :count)
        end
    end
  end

  describe "PUT /api/v1/projects" do
    context "when the project exists" do
        let(:project) { create(:project) }
        let(:project_attributes) { attributes_for(:project) }

        before(:each) { put "/api/v1/projects/#{project.id}", params:  { project: project_attributes }  }

        it 'returns status code 200' do
            expect(response).to have_http_status(200)
        end
        it 'updates the record' do 
            expect(project.reload).to have_attributes(project_attributes)
        end
        it 'returns the project updated' do
            expect(project.reload).to have_attributes(json.except('created_at', 'updated_at'))
        end
    end

    context 'when the project does not exist' do
        let(:project_attributes) { attributes_for(:project) }
        before(:each) { put "/api/v1/projects/0", params:  { project: project_attributes }  }
        
        it 'returns status code 404' do
            expect(response).to have_http_status(404)
        end
        it 'returns a not found message' do
            expect(response.body).to match(/Couldn't find Project/)
        end
    end
  end
  describe "DELETE /api/v1/projects" do
    context 'when the project exists' do
        let(:project) { create(:project) }
        before(:each) { delete "/api/v1/projects/#{project.id}" }

        it 'returns status code 200' do
            expect(response).to have_http_status(204)
        end
        it 'destroy the record' do
            expect { project.reload }.to raise_error ActiveRecord::RecordNotFound
        end
    end
    context 'when the project does not exist' do
        before(:each) { delete "/api/v1/projects/0" }

        it 'returns status code 404' do
            expect(response).to have_http_status(404)
        end
        it 'returns a not found message' do
            expect(response.body).to match(/Couldn't find Project/)
        end
    end
  end
end