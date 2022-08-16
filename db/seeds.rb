# ◆postgresメモ
# rails dbconsole
# select * from letters;


#############
## User生成 ##
#############

    admin = User.create(
        :name     => 'admin',
        :email    => 'admin@example.com', 
        :password => 'makutaro',
        :location => '千葉県',
        :like_thing=> 'くまさん')

    user01 = User.create(
        :name     => 'user01',
        :email    => 'user01@example.com', 
        :password => 'makutaro',
        :location => '東京都',
        :like_thing=> 'うさぎさん')

    user02 = User.create(
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
        :title      => '子供が野菜をたべません',
        :content    => '初めまして! 私には悩みがあります。私には６歳になる子供がいるのですが、最近になってまったく野菜を食べてくれません。主人も「子供は肉を食え」と意にもしないのですが、私は子供が将来偏食のなってしまうのではないかととても不安です。なにかアドバイスをいたああだけないでしょうか。',
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
        :title      => 'user01です_返信です',
        :content    => 'テスト',
        :to_user_id => admin.id,
        :layout_id  => 1,
        :reply_flag => true
    )

    Letter.create(
        :user_id    => user02.id,
        :title      => 'user02です',
        :content    => 'テスト',
        :to_user_id => admin.id,
        :layout_id  => 2
        )

##################
## Information  ##
##################
    Information.create( :content  => 'リリース開始！',)
    Information.create( :content  => '二人三脚には自身があります',)
    Information.create( :content  => 'サンシャイン水族館に行きたい',)