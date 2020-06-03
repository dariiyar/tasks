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
    if @valid
      @tasks.each(&:save)
      OpenStruct.new(success?: true, tasks: @tasks)
    else
      OpenStruct.new(success?: false, tasks: nil, errors: @errors)
    end
  end

  private

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
