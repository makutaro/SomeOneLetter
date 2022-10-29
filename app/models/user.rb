class User < ApplicationRecord
  has_many :inbox_records
  has_many :letters 
  has_one_attached :image
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # valid定義
  validates :name,  presence: true, length: { in: 4..20  }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  validates :location, presence: true
  validates :like_thing, presence: true
  validates :image,   content_type: { in: %w[image/jpeg image/gif image/png],
                                      message: "画像のフォーマットが不適切です" },
                             size:  { less_than: 5.megabytes,
                                      message: "画像のサイズが5MBを超えています" }

  def image=(val)
    # val = MiniMagick.source(val).resize "30, 30"
    val = self.image.variant(resize_to_limit: [30, 30])
    debugger
  end

 # enum定義
 enum location: {
    北海道:1,青森県:2,岩手県:3,宮城県:4,秋田県:5,山形県:6,福島県:7,
    茨城県:8,栃木県:9,群馬県:10,埼玉県:11,千葉県:12,東京都:13,神奈川県:14,
    新潟県:15,富山県:16,石川県:17,福井県:18,山梨県:19,長野県:20,
    岐阜県:21,静岡県:22,愛知県:23,三重県:24,
    滋賀県:25,京都府:26,大阪府:27,兵庫県:28,奈良県:29,和歌山県:30,
    鳥取県:31,島根県:32,岡山県:33,広島県:34,山口県:35,
    徳島県:36,香川県:37,愛媛県:38,高知県:39,
    福岡県:40,佐賀県:41,長崎県:42,熊本県:43,大分県:44,宮崎県:45,鹿児島県:46, 
    沖縄県:47,その他:48
}
  # (現在未使用)プロフィールアイコン表示用のリサイズ済み画像を返す
  def display_image
       image.variant(resize_to_limit: [70, 70])
     end

  # dammy生成用のクラスメソッド(作成数,)
  def self.create_dammy(num, to_user_id)
    num.times do |f|
      a= User.create(
        :name     => "user#{ f.to_s }",
        :email    => "user#{ f.to_s }@example.com", 
        :password => 'makutaro',
        :location => '東京都',
        :like_thing=> 'うさぎさん')
      a.create_letter(to_user_id)
    end
  end

    # letter生成用のメソッド
    def create_letter(to_user_id)
      @letter= Letter.create(
          :user_id    => self.id,
          :title      => "#{ self.id }のUserの1通目",
          :content    => "テストです"
      )
      @match_room = @letter.build_match_room
      @inbox_record = @match_room.inbox_records.build( user_id: to_user_id, to_user_id: self.id )
      @letter.save!
    end

  # 条件に合致するuser_idを検索 => activeかつランダム
  def self.find_to_user_id(self_id)
    User.where(active_flag:true).where.not(id:self_id).pluck(:id).shuffle!.first
  end
  
  # 現在返信可能なletterの数を返す　
  def count_replayable
    count = 0
    InboxRecord.where(user_id: self.id, hidden_flag: false).map do |f|
     count += 1 if f.last_letter.user_id != self.id   
    end
    return count
  end

  # sendable_countを1減らす
  def reduce_sendable_count!
    self.sendable_count -= 1
    self.save
  end
end