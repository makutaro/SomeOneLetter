class Letter < ApplicationRecord
  # 単一のuserに紐づく
  belongs_to :user

   # デフォルトの並び順を定義(降順)
   default_scope -> { order(created_at: :desc) }

   # バリデーション
   validates :title, presence: true, length: { maximum: 20 }
   validates :content, presence: true, length: { maximum: 300 } # 手紙の有効文字数は要件等
   validates :to_user_id, presence: true                        # 宛先ユーザidをpresence:trueにするかは要検討

end
