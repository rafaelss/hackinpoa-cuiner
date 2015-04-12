class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :phone, :photo_url

  def id
    object.public_id
  end
end
