class Book < ActiveRecord::Base
  belongs_to :type

  validates :title, presence: true
  validates :description, presence: true
  validates :cost, presence: true

end
