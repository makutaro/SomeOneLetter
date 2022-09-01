class InboxRecord < ApplicationRecord

    # 関連付け
    belongs_to :user
    belongs_to :to_user, class_name: 'User', :foreign_key => 'to_user_id'
    belongs_to :match_room
    has_many   :letters

    # scope
    scope :find_all_by_id, -> (id) { where(user_id: id).order(updated_at: :desc) }

end
