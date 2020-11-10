require 'swagger_helper'

RSpec.describe '/api/v1/projects', type: :request do
    path "/api/v1/projects" do
        post "Create a Project" do
            tags "Projects"
            consumes "application/json"
            parameter name: :project, in: :body, schema: {
                type: :object,
                properties: {name: { type: :string }},
                required: ["name"],
            }
            response "201", "project created" do
                let(:project) { { name: "Teste" } }
                run_test!
            end
            response "422", "invalid request" do
                let(:project) { { name: nil } }
                run_test!
            end
        end
    end
end
