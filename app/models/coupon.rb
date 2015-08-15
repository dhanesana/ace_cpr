class Coupon < ActiveRecord::Base
  belongs_to :type

  validates :type_id, presence: true

end
