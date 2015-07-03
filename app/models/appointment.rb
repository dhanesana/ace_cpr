class Appointment < ActiveRecord::Base
  belongs_to :admin_user
  has_many :users
end
