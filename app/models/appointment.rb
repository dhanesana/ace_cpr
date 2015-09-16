class Appointment < ActiveRecord::Base
  belongs_to :admin_user
  belongs_to :type
  has_many :users

  has_many :primary_relationships,
            class_name: 'Combo',
            foreign_key: 'secondary_id'

  has_many :secondary_relationships,
            class_name: 'Combo',
            foreign_key: 'primary_id'

  has_many :primaries, through: :primary_relationships
  has_many :secondaries, through: :secondary_relationships

  validates :type_id, presence: true

  def formated_date
    class_date.strftime("%B %d, %Y %I:%M %p")
  end

end
