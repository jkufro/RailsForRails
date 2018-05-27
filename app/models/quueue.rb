class Quueue < ApplicationRecord
  belongs_to :visit
  belongs_to :ride
  
  validates_format_of :queue_code, with: /\A[A-Z]{5}\z/, message: "must be five upper case letters"
end
