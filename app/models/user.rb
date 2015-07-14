class User < ActiveRecord::Base
  belongs_to :appointment

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :appointment_id, presence: true
  validates :phone, presence: true
  validates :email, uniqueness: true

  phony_normalize :phone, as: :formatted_phone, default_country_code: 'US'
end
