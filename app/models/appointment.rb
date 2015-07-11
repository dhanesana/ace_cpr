class Appointment < ActiveRecord::Base
  belongs_to :admin_user
  has_many :users

  def formated_date
    class_date.strftime("%B %d, %Y %I:%M %p")
  end

end
