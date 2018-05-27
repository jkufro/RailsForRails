class ParkPass < ApplicationRecord
    belongs_to :pass_type
    belongs_to :user 
    has_many :visits
    has_many :quueues, through: :visits
    
    validates_format_of :card_number, with: /\A[A-Z]\d{15}\z/, message: "is not a valid format"
    validates_timeliness_of :card_expiration, :on => :create, :on_or_after => :today, :message => "must be today or in the future"
    
    def expired?
      
    end
end
