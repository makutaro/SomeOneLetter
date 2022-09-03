class Letter < ApplicationRecord
  belongs_to :user
  belongs_to :match_room

   # スコープ
   scope :find_all_by_id, -> (id) { where(match_room_id: id).order(created_at: :asc) }

   # バリデーション
   validates :title, presence: true, length: { maximum: 20 }
   validates :content, presence: true, length: { maximum: 300 } # 手紙の有効文字数は要件等

   # ランダムなユーザのIDを取得
   def set_to_user_id
    # 暫定で 1~10の値を返却  本来はアクティブ率を基に参照する必要あり
    self.to_user_id = rand(10)+1
   end

   def save_safe
    if self.save # DBに保存
      # flash[:success] = "投稿しました"
    else # DBエラー
     #  flash[:danger] = "DBエラーです"
      redirect_to request.referrer || root_url
    end
   end
end