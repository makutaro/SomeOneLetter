# README

##############
##    git   ##
##############

  ## 初期設定コマンド
    git init                                           => 新規リポジトリ作成。railsはデフォで実行済み
    git config --global user.name "Akira_Yajima"           => 名前を設定
    git config --global user.email tw21wryy@gmail.com  => emailを設定
    git config --global alias.co checkout              => checkout=co のエイリアス
    git config --global credential.helper (linux)"cache --timeout=86400" 
                                          (win)wincred                   => passのキャッシュ保持
    git config --global -l                             => 設定のリスト表示
    git config --global -unset [value]                 => 設定の削除          

    git remote add origin https://github.com/makutaro/[PJ_NAME] => リモートoriginの設定(今回はgithub)
        * 事前にgithubにリポジトリを作成しておくこと!

  ## コミット操作コマンド
    git add -A              => 対象ファイルをステージング(-A=ALL)
    git commit -m "MESSAGE" => ローカルリポジトリに保存(-aで add -A を含む)
    git push origin master  => リモートリポジトリに保存

    git checkout -b "新規ブランチ名"   => ブランチを作成し移動
    git checkout -f                    => 直前のコミットまで戻る  
    git checkout master               => masterへ移動
    git merge "ブランチ名"            =>対象ブランチ名を現在のブランチをマージ

 ## コミット確認コマンド
    git status              => ステージングされているファイルの確認
    git log                 => コミット状況の確認

##############
##  Docker  ##
##############

 ## 運用コマンド
    docker-compose exec web bash
