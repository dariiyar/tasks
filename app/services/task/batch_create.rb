class Task::BatchCreate
  def self.perform(*args, &block)
    new(*args, &block).perform
  end

  def initialize(tasks_params)
    @tasks = []
    @errors = []
    tasks_params.each do |task_param|
      @tasks << Task.new(task_param)
    end
  end

  def perform
    check_valid
    if @errors.empty?
      @tasks.each(&:save)
      OpenStruct.new(success?: true, tasks: @tasks)
    else
      OpenStruct.new(success?: false, tasks: nil, errors: @errors)
    end
  end

  private

  def check_valid
    @tasks.each { |t| @errors << t.errors unless t.valid? }
  end
end
