class Project::Create
  def self.perform(*args, &block)
    new(*args, &block).perform
  end

  def initialize(project)
    @project = project
  end

  def perform
    return OpenStruct.new(success?: false, project: nil, errors: @project.errors) unless @project.save
    OpenStruct.new(success?: true, project: @project)
  end
end
