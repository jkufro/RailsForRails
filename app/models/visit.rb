class Visit < ApplicationRecord
    belongs_to :park_pass
    has_many :quueues
end
