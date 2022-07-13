
◆原因 
rail7においてTurboが反応しない
httpのdestroyメソッドが解決されない(getになる)

◆結論
turbo-rails と redis がイントールされていないなかった。

◆解決手順
実行 =>  [rails importmap:install]
実行 =>  [rails turbo:install:redis]
 => bundleのversionが[2.3.7]の為エラー
実行 =>  [gem install bundler -v 2.3.10]
実行 =>  [bundle _2.3.10_ update]
実行 =>  [rails turbo:install:redis]

◆備考
・gemfileに下記がインスト―ルされている事は確認済み
  # gem "turbo-rails"
  # gem "stimulus-rails"

・[rails turbo:install]を実行したところ、下記のエラー
  # You must either be running with node (package.json) or importmap-rails (config/importmap.rb) to use this gem.
  => [rails importmap:install] を実行し解決
  [rails turbo:install]を実行
  => [rails turbo:install:redis]を実行
=> bundleのversionが[2.3.7]の為エラー。
   [gem install bundler -v 2.3.10]を実行
   [gem update --system]を実行
   [bundle _2.3.10_ update]
   [rails turbo:install:redis]

