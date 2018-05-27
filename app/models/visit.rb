class Visit < ApplicationRecord
    belongs_to :park_pass
    has_many :quueues
    
    validates_presence_of :visit_date, :park_pass_id
    validates_timeliness_of :visit_date, :on => :create, :is_at => Date.today
    
    before_create :pass_cannot_be_expired
    
    private
    
    def pass_cannot_be_expired
      if self.park_pass.expired?
        errors.add(:park_pass, "is expired")
      end
    end
end
