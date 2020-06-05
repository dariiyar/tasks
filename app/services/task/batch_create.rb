class Task::BatchCreate
  def self.perform(*args, &block)
    new(*args, &block).perform
  end

  def initialize(tasks_params)
    @tasks = []
    @errors = []
    @valid = true
    tasks_params.each do |task_param|
      @tasks << Task.new(task_param)
    end
  end

  def perform
    check_valid
    save_tasks if @valid
    return OpenStruct.new(success?: true, tasks: @tasks) if @valid
    OpenStruct.new(success?: false, tasks: nil, errors: @errors)
  end

  private

  def save_tasks
    @tasks.each do |task|
      task.initialized!
      task.save
    end
  end

  def check_valid
    @tasks.each do |t|
      if t.valid?
        @errors << {}
      else
        @errors << t.errors
        @valid = false
      end
    end
  end
end
