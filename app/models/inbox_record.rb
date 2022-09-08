class InboxRecord < ApplicationRecord

    # 関連付け
    belongs_to :user
    belongs_to :to_user, class_name: 'User', :foreign_key => 'to_user_id'
    belongs_to :match_room

    # scope
    scope :find_all_by_id, -> (id) { where(user_id: id).order(updated_at: :desc) }

    # 検索条件
    # 「[letterが1通しかない] かつ [それが自身のletter] 」以外を返却
    scope :filter_no_reply_letter, -> { where.not("? = 1", self.first.match_room.letters.count)
                                              .or("? = ?", self.first.match_room.letters.first.user_id,self.first.user_id)
                                      }

end