class Ride < ApplicationRecord
    has_many :quueues
    
    validates_format_of :max_allowed_queue_code, with: /\A[A-Z]{5}\z/, message: "must be five upper case letters"
    validates_numericality_of :carts_on_track, :greater_than => 0, :only_integer => true
end
