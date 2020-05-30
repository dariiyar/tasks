class TaskSerializer < ActiveModel::Serializer
  attributes :uuid, :name, :description, :estimate_date, :price, :status, :progress, :project

  def uuid
    object.id
  end

  def project
    ProjectSerializer.new(object.project).attributes
  end
end
