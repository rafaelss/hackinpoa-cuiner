class User < ActiveRecord::Base
  has_secure_password

  validates_presence_of :name, :email, :public_id
  validates_uniqueness_of :email, allow_blank: true

  before_validation :set_public_id, on: :create

  def to_param
    public_id
  end

  protected

  def set_public_id
    self.public_id = SecureRandom.uuid
  end
end