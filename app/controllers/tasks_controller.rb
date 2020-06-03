class TasksController < ApplicationController
  def index
    render json: Task.all, status: :ok
  end

  def batch_create
    result = Task::BatchCreate.perform(tasks_params[:tasks])
    if result.success?
      render json: result.tasks, status: :created
    else
      render json: { errors: result.errors }, status: :unprocessable_entity
    end
  end


  private

  def tasks_params
    params.permit(
        tasks: [
            :name,
            :description,
            :price,
            :estimate_date,
            :urls,
            :status,
            :progress,
            :project_id,
            urls: []
        ]
    )
  end
end
