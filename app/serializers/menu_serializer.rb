class MenuSerializer < ActiveModel::Serializer
  attributes :id, :name

  def id
    object.public_id
  end
end
