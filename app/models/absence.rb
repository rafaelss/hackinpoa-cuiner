class Absence < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :at, :shift
  validates_inclusion_of :shift, in: ["morning", "afternoon", "night"], allow_blank: true
end
