class ProjectsController < ApplicationController
  def index
    render json: Project.all, status: :ok
  end

  def create
    result = Project::Create.perform(Project.new(project_params))
    if result.success?
      render json: result.project, status: :created
    else
      render json: { errors: result.errors }, status: :unprocessable_entity
    end
  end

  private

  def project_params
    params.permit(:name, :description, :price)
  end
end
