class Type < ActiveRecord::Base
  has_many :appointments

  validates :name, presence: true
  validates :blurb, presence: true
  validates :description, presence: true
  validates :cost, presence: true

end
