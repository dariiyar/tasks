class ProjectSerializer < ActiveModel::Serializer
  attributes :uuid, :name, :description, :price

  def uuid
    object.id
  end
end
