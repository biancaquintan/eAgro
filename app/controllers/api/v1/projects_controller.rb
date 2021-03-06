class Api::V1::ProjectsController < Api::V1::ApiController
    before_action :set_project, only: [:show, :update, :destroy]

    # GET /api/v1/projects
    def index  
        @projects = Project.all

        render json: @projects
    end

    # GET api/v1/projects/:id
    def show
        render json: @project
    end

    # POST /api/v1/projects
    def create
        @project = Project.new(project_params)

        if @project.save
            render json: @project, status: :created
        else
            render json: @project.errors, status: :unprocessable_entity
        end
    end

    # PATCH/PUT /api/v1/projects/:id
    def update
        if @project.update(project_params)
            render json: @project
        else
            render json: @project.errors, status: :unprocessable_entity
        end
    end

    # DELETE /api/v1/projects/:id
    def destroy
        @project.destroy
    end

    private

        def set_project
            @project = Project.find(params[:id])
        end

        def project_params
            params.require(:project).permit(:name)
        end
end
