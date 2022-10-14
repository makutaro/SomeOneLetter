class MatchRoom < ApplicationRecord
    has_many :letters 
    has_many :inbox_records

end
