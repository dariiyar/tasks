class Task::UrlFilesUploaderJob
  include Sidekiq::Worker

  def perform(task_id)
    task_id = task_id
    binding.pry
  end
end