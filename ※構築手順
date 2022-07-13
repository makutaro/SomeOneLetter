version

1.0.0 新規作成
 ・以下２つのコンテナを起動
   ・web(rails_v6.1.4.1) 
   ・db(postgres)

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

環境作成手順

1. 作業ディレクトリにこのファイルのあるフォルダを丸ごとコピー
   フォルダ名をプロジェクト名にリネーム

2. docker-compose.ymlの"PJ_NAME"をプロジェクト名に置換
   ※ windowsの場合、改行コードに注意(正:LF)

3. poweshellを起動
   'cd [dir名]' <= ディレクトリ移動
   'docker-compose run --no-deps web rails new . --force --database=postgresql --skip-bundle' - 
                   docker-compose run web      => webコンテナのみを起動(暗黙でbuildされる)
                    --no-deps                  => 依存関係を無視(db)
                   rails new .                 => workdir直下にrails new
                    --force                    => すでに存在するファイルを上書く
                    --database=postgresql      => dbはpostgres用の初期設定でセットアップ
                    --skip-bundle              => デフォルトのgemが読み込まれるのでスキップ

4. 'docker-compose build' <= image作成。bundle installも実施
5. 

対処法は、development.rbファイルを1行変更するのみです。
config.file_watcherの値を、FileUpdateCheckerにします。

