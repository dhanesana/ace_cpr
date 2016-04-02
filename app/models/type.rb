class Type < ActiveRecord::Base
  has_many :appointments
  has_many :textbooks
  has_many :books

  validates :name, presence: true
  validates :blurb, presence: true
  validates :description, presence: true
  validates :cost, presence: true

end
