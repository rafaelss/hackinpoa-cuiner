class Menu < ActiveRecord::Base
  include AlgoliaSearch

  belongs_to :user

  validates_presence_of :name, :price, :price_per_person
  validates_numericality_of :price, greater_then: 0, allow_blank: true
  validates_numericality_of :price_per_person, allow_blank: true

  before_validation :set_public_id, on: :create

  delegate :name, :bio, to: :user, prefix: true

  algoliasearch(per_environment: true, disable_indexing: Rails.env.test?, synchronous: Rails.env.development?) do
    attribute :name, :tags, :user_name, :user_bio
    attribute :price do
      price.to_f
    end
    attribute :max_number_of_people do
      number_of_people.max
    end
  end

  def to_param
    public_id
  end

  protected

  def set_public_id
    self.public_id = SecureRandom.uuid
  end
end
