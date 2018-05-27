class Ride < ApplicationRecord
    has_many :quueues
    
    validates_format_of :max_allowed_queue_code, with: /\A[A-Z]{5}\z/, message: "must be five upper case letters"
end
