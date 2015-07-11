class User < ActiveRecord::Base
  belongs_to :appointment

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone, presence: true
end
