# ◆postgresメモ
# rails dbconsole
# select * from letters;


#############
## User生成 ##
#############

    admin = User.create(
        :id       => '1',
        :name     => 'admin',
        :email    => 'admin@example.com', 
        :password => 'makutaro',
        :location => '千葉県',
        :like_thing=> 'くまさん')

    user01 = User.create(
        :id       => '2',
        :name     => 'user01',
        :email    => 'user01@example.com', 
        :password => 'makutaro',
        :location => '東京都',
        :like_thing=> 'うさぎさん')

    user02 = User.create(
        :id       => '3',
        :name     => 'user02',
        :email    => 'user02@example.com', 
        :password => 'makutaro',
        :location => '静岡県',
        :like_thing=> 'かめさん')


#############
## Letter  ##
#############


    Letter.create(
        :user_id    => admin.id,
        :title      => '1通目',
        :content    => 'テスト！',
        :to_user_id => user01.id,
        :layout_id  => 1
    )

    Letter.create(
        :user_id    => admin.id,
        :title      => '2通目',
        :content    => 'げんきか！',
        :to_user_id => user02.id,
        :layout_id  => 2
    )

    Letter.create(
        :user_id    => user01.id,
        :title      => 'user01です',
        :content    => 'テスト',
        :to_user_id => admin.id,
        :layout_id  => 1
    )

    Letter.create(
        :user_id    => user02.id,
        :title      => 'user02です',
        :content    => 'テスト',
        :to_user_id => admin.id,
        :layout_id  => 2
        )



# # created_atを昇順(デフォ)で並び替え、上から6人をusersに格納
# users = User.order(:created_at).take(6)
# 50.times do
#   content = Faker::Lorem.sentence(word_count: 5)
#   users.each { |user| user.microposts.create!(content: content) }
# end
