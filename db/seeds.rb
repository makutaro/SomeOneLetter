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

    User.create_dammy(10,admin.id)


#############
## Letter  ##
#############


##################
## Information  ##
##################
    Information.create( :content  => 'リリース開始！',)
    Information.create( :content  => '二人三脚には自身があります',)
    Information.create( :content  => 'サンシャイン水族館に行きたい',)