class InboxRecord < ApplicationRecord
    belongs_to :user
    belongs_to :to_user, class_name: 'User', foreign_key :to_user_id
    belongs_to :match_room
    has_many   :letters

end
