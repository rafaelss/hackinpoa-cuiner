class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email

  def id
    object.public_id
  end
end
