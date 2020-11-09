class Api::V1::TasksController < Api::V1::ApiController
    before_action :set_project
    before_action :set_task, only: [:show, :update, :destroy]
    
    # GET /api/v1/projects/:project_id/tasks
    def index  
        @tasks = @project.tasks

        render json: @tasks
    end

    # GET /api/v1/projects/:project_id/tasks/:id
    def show
        render json: @task
    end

    # POST /api/v1/projects/:project_id/tasks
    def create
        @task = Task.new(task_params.merge(project_id: params[:project_id]))

        if @task.save
            render json: @task, status: :created
        else
            render json: @task.errors, status: :unprocessable_entity
        end
    end

    # PATCH/PUT /api/v1/projects/:project_id/tasks/:id
    def update
        if @task.update(task_params)
            render json: @task
        else
            render json: @task.errors, status: :unprocessable_entity
        end
    end

    # DELETE /api/v1/projects/:project_id/tasks/:id
    def destroy
        @task.destroy
    end

    private

        def set_project
            @project = Project.find(params[:project_id])
        end

        def set_task
            @task = @project.tasks.find(params[:id])
        end

        def task_params
            params.require(:task).permit(:date, :description, :status, :project_id)
        end
end
