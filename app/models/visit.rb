class Visit < ApplicationRecord
    belongs_to :park_pass
    has_many :quueues
    
    validates_presence_of :visit_date, :park_pass_id
    validates_timeliness_of :visit_date, :on => :create, :is_at => Date.today
end
