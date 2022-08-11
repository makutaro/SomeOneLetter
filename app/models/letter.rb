class Letter < ApplicationRecord
  # 単一のuserに紐づく
  belongs_to :user

   # デフォルトの並び順を定義(降順)
   default_scope -> { order(created_at: :desc) }

   # getter,setter定義

   # バリデーション
   validates :title, presence: true, length: { maximum: 20 }
   validates :content, presence: true, length: { maximum: 300 } # 手紙の有効文字数は要件等
   validates :layout_id, presence: true

   # ランダムなユーザのIDを取得
   def set_to_user_id
    # 暫定で 1~10の値を返却  本来はアクティブ率を基に参照する必要あり
    self.to_user_id = rand(10)+1
   end

   enum layout_id: {
    ピンク:1,
    水色:2
   }

end