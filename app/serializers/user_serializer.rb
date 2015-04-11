class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email

  def id
    object.public_id
  end
end
