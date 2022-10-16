class InboxRecord < ApplicationRecord
    # 関連付け
    belongs_to :user
    belongs_to :to_user, class_name: 'User', :foreign_key => 'to_user_id'
    belongs_to :match_room
    has_many :letters, through: :match_room
    has_one  :last_letter, -> { order(created_at: :desc).limit(1) }, through: :match_room, source: :letters

    # scope 
    scope :find_all_by_id,    -> (user_id) { where(user_id: user_id,hidden_flag: false).includes([:user, match_room: :letters]).order(updated_at: :desc) }
  
    # 検索条件
    # 「[letterが1通しかない] かつ [それが自身のletter] 」以外を返却
    scope :filter_no_reply_letter, -> { where.not("? = 1", self.first.match_room.letters.count)
                                              .or("? = ?", self.first.match_room.letters.first.user_id,self.first.user_id)
                                      }

    # 返信のないレコードを除外するメソッド
    def ignore_wait_reply_records!
        if (self.match_room.letters.count == 1 && self.match_room.letters.first.user_id == self.user.id)
          return nil  # 除外
        end
          return self # 除外しない
    end
end