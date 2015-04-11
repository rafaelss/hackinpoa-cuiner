class Menu < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :name, :price, :price_per_person
  validates_numericality_of :price, greater_then: 0, allow_blank: true
  validates_numericality_of :price_per_person, allow_blank: true

  before_validation :set_public_id, on: :create

  def to_param
    public_id
  end

  protected

  def set_public_id
    self.public_id = SecureRandom.uuid
  end
end
