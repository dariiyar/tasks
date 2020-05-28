class ProjectSerializer < ActiveModel::Serializer
  attributes :uuid, :name, :description, :price, :estimate_date, :progress, :status, :task_count

  def uuid
    object.id
  end
end
