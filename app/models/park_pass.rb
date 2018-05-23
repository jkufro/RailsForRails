class ParkPass < ApplicationRecord
    belongs_to :pass_type
    belongs_to :user 
    has_many :visits
    has_many :quueues, through: :visits
end
