class Type < ActiveRecord::Base
  has_many :appointments
  has_many :prices
end
