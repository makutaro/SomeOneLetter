class MatchRoom < ApplicationRecord
    has_many :letters 
    has_many :match_room_users
end
