class MenuSerializer < ActiveModel::Serializer
  attributes :id, :name, :price, :price_per_person, :number_of_people, :tags

  def id
    object.public_id
  end

  def price
    object.price.to_f
  end

  def price_per_person
    object.price_per_person.to_f
  end
end
