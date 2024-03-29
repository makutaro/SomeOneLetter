class Letter < ApplicationRecord
  belongs_to :user
  belongs_to :match_room
  
   # スコープ
   scope :find_all_by_id, -> (id) { where(match_room_id: id).includes(:user).order(created_at: :asc) }

   # バリデーション
   validates :title, presence: true, length: { maximum: 20 }
   validates :content, presence: true, length: { maximum: 300 } # 手紙の有効文字数は要件

   # ランダムなユーザのIDを取得
   def set_to_user_id
    # 暫定で 1~10の値を返却  本来はアクティブ率を基に参照する必要あり
    self.to_user_id = rand(10)+1
   end

   def self.build_dammy
        self.new(
          title:   "dammy_title",
          content: "dammy_content"
        )
   end
   
end