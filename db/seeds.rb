# ◆postgresメモ
# rails dbconsole
# select * from letters;


#############
## User   ##
#############

admin = User.create(
    :name     => 'admin',
    :email    => 'admin@example.com', 
    :password => 'makutaro',
    :location => '千葉県',
    :like_thing=> 'くまさん')

sample_01 = User.create(
    :name     => 'たぬきさん',
    :email    => 'sample01@example.com', 
    :password => 'sample01',
    :location => '千葉県',
    :like_thing=> 'くまさん')
sample_01.image.attach(
    io: File.open(Rails.root.join('app/assets/images/tanuki.png')),
    filename: 'tanuki.png')

sample_02 = User.create(
    :name     => 'ぞうさん',
    :email    => 'sample02@example.com', 
    :password => 'sample02',
    :location => '大阪府',
    :like_thing=> 'しかさん')
sample_02.image.attach(
    io: File.open(Rails.root.join('app/assets/images/zou.png')),
    filename: 'zou.png')

sample_03 = User.create(
    :name     => 'うさぎさん',
    :email    => 'sample03@example.com', 
    :password => 'sample03',
    :location => '長野県',
    :like_thing=> 'うさぎさん')
sample_03.image.attach(
    io: File.open(Rails.root.join('app/assets/images/usagi.png')),
    filename: 'usagi.png')

# dammyユーザーを5人作成
dammy_users = User.create_dammy(5)

#############
## Letter  ##
#############

room_id_01 = sample_01.send_letter_new(sample_02.id,"この手紙を読んでいるあなたへ","はじめまして！\n好きなラーメンの話がしたいです!\nラーメン好きな人に届くといいな💦")
             sample_02.send_letter_reply(sample_02.id,"たぬきさんへ","はじめまして！僕もラーメン大好きです！！\n家系ラーメンを年間1000杯食べてます！",room_id_01)
             sample_01.send_letter_reply(sample_01.id,"ぞうさんへ","食べすぎ。。笑",room_id_01)

room_id_02 = sample_02.send_letter_new(sample_03.id,"この手紙を読んでいるあなたへ","はじめまして！\n最近仕事がしんどくて。。。😢!\n話を聴いてくださる方募集です～")
             sample_03.send_letter_reply(sample_02.id,"ぞうさんへ","はじめまして！僕でよければききますよ～！\nお仕事は何をしているんですか🤔",room_id_02)
             sample_02.send_letter_reply(sample_03.id,"うさぎさんへ","蟹工船で働いてて。。。😢",room_id_02)

room_id_03 = sample_03.send_letter_new(sample_01.id,"この手紙を読んでいるあなたへ","ねむい！")
             sample_01.send_letter_reply(sample_03.id,"うさぎさんへ","ぼくも！",room_id_03)
             sample_03.send_letter_reply(sample_01.id,"たぬきさんへ","なかま！",room_id_03)

User.find_by(name: "dammy_1").send_letter_new(sample_01.id,"この手紙を読んでいるあなたへ","こんにちは！")
User.find_by(name: "dammy_1").send_letter_new(sample_02.id,"この手紙を読んでいるあなたへ","こんにちは！")
User.find_by(name: "dammy_1").send_letter_new(sample_03.id,"この手紙を読んでいるあなたへ","こんにちは！")

User.find_by(name: "dammy_2").send_letter_new(sample_01.id,"この手紙を読んでいるあなたへ","だれかお話しませんか～")
User.find_by(name: "dammy_2").send_letter_new(sample_02.id,"この手紙を読んでいるあなたへ","だれかお話しましょ～")
User.find_by(name: "dammy_2").send_letter_new(sample_03.id,"この手紙を読んでいるあなたへ","だれかかまってください～")

User.find_by(name: "dammy_3").send_letter_new(sample_01.id,"この手紙を読んでいるあなたへ","とどけ～！")
User.find_by(name: "dammy_3").send_letter_new(sample_02.id,"この手紙を読んでいるあなたへ","ひま～")
User.find_by(name: "dammy_3").send_letter_new(sample_03.id,"この手紙を読んでいるあなたへ","だれか～しゃべろ～")

##################
## Information  ##
##################

    Information.create( :content  => 'リリース開始',)
    Information.create( :content  => '就職活動開始',)
    Information.create( :content  => '2022年内にサービス閉鎖予定です',)