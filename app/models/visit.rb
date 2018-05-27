class Visit < ApplicationRecord
    belongs_to :park_pass
    has_many :quueues
    
    validates_timeliness_of :visit_date, :on => :create, :is_at => Date.today
end
