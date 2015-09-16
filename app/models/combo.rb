class Combo < ActiveRecord::Base
  belongs_to :primary,   class_name: "Appointment"
  belongs_to :secondary, class_name: "Appointment"
end
