# SomeOneLetter

## 概要
SomeOneLetterは、手紙を瓶に詰めて海に流す営みから着想を得た、**世界一気軽なマッチング型文通サービス** です。<br>
* あなたが手紙を海に流すと、その手紙がアクティブな他のユーザのもとに流れ着きます。(送信)<br>
* 同様に、あなたは誰かから届いた手紙を確認し、その手紙の送り主に返信することができます。(返信)<br>
* 返信は確実に相手のもとへ届き、その後、継続的に文通を行う事ができます。あとはごゆっくり。(マッチング)<br>

## 画面抜粋
<img width="1399" alt="キャプチャ連結2" src="https://user-images.githubusercontent.com/92739738/200179755-f9534e27-a4cf-4689-96aa-daae8e418566.PNG">

<img width="1354" alt="キャプチャ_連結" src="https://user-images.githubusercontent.com/92739738/200179674-a83b081c-2ccc-437f-ae8c-fb21ec246c1a.PNG">

## URL
https://someoneletter.com/ <br>
※コストの都合上、面接時以外は開放しておりません。<br>
* サンプルユーザー(メールアドレス,パスワード)
  * ID：sample01@example.com, sample01
  * ID：sample02@example.com, sample02
  * ID：sample03@example.com, sample03<br>

※**3ユーザーの状態にあまり差はないため、どれを使っていただいても問題ありません。**<br>
※**2,3日間隔でDBをリセットする為、好きに触って頂いて構いません。**



## 開発意図
本サービスの開発意図は主に以下の二点です。<br>
* 技術ポートフォリオとして、「ECサイト」「twitter_likeなSNS」「典型的なマッチングアプリ」のような、<br>
開発ノウハウが公開されているものではなく、DB設計やドメインの振る舞いが1から検討されたサービスを作成する必要があると考えたため。<br>

* twitterやfacebookのような「フォロワーが多い人ほど声が大きくなる」性質をもつコミュニケーションSNSのアンチテーゼとして、<br>**総理大臣も小学生も、完全に平等にコミュニケーションを行えるSNS**を作ってみたいと考えたため。<br>

## 仕様技術
* フロントエンド
  * HTML/CSS
  * SCSS
  * Javascript
  * bootstrap 5.1.3
  * webpack
  * jquery 3.4.1
  * Ajax
* バックエンド
  * Ruby 2.7.6
  * Ruby on Rails 6.1.4
  * minitest
* インフラ
  * Docker / Docker-compose
  * AWS (ECS / Fargate / RDS / S3 / VPC / IAM / Route53 / ACM / ALB ) 
  * CircleCI
  * Postgres / Puma / Nginx
* 今後実装予定
  * テストコード改修 minitest => Rspec (実施中)
  * terraformインフラのコード化
  * Next.jsによフロントエンドの完全SPA化

## こだわり
* スマホ操作を想定したUI設計。レスポンシブデザイン対応。
* nginx + rails + RDS　によるWeb3層アーキテクチャの実現
* ECS + Fargate によるインフラの完全サーバレス可による運用コストへのアプローチ
* AutoScaling、冗長構成(単一障害点なし)、負荷分散、商用運用を想定した可用性、保守性へのアプローチ
* ユーザーのactive機能、期限切れの手紙の自動リリース機能など、手紙の循環を促す機能の実装

## ER図
![ER図 (2)](https://user-images.githubusercontent.com/92739738/200176935-8f90128f-a857-45d7-a9b6-254c9a34477f.png)

## インフラ構成図
![aws_infra](https://user-images.githubusercontent.com/92739738/200003088-5a49d90a-51e2-4612-aa30-ddc785100445.png)

## 機能一覧
 * 新規登録、ログイン機能
 * プロフィール編集機能
 * 手紙の閲覧機能
 * 手紙の新規投稿機能
 * 手紙の返信機能
 * 手紙のリリース機能
 * 手紙のブロック機能
 * 期限切れの手紙の自動リリース機能(実装中)
 * 30日間未ログイン時のユーザーの非アクティブ化機能(実装中)

## 最後に。転職活動における意気込み。
 お忙しい中、閲覧頂きありがとうございます。
* 不足する技術(フロントエンドフレームワーク,Rspecによるテスト等)については、参画前、及び参画後の業務時間外で確実にキャッチアップします。<br>
* コーディングに限らず、インフラにも強い関心があります(AWS_saa保有済み)。入社後一年以内に、担当サービスにおけるインフラ担当の分身になります。<br>
* お時間は頂きません。採用担当様の都合が合い次第、是非ともオフラインで直接会話をさせて頂きたいです。

## 備考 ～localでの環境再現手順～

### 前提条件
* docker-desktopをインストール済み
* gitをインストール済み
* ホストマシンのポート80を開放していないこと。(本アプリで使用するため)

### 手順
1. 任意のディレクトリで下記コマンドを実行<br>
   * `git clone https://github.com/makutaro/SomeOneLetter.git`
2. SomeOneLetter直下に移動し、以下を実行
   * `docker-comopse build` (sassc 2.4.0のインストールに何故か2分程かかります💦。現在原因解析中)
   * `docker-compose up`
3. コンテナが全て起動したことを確認したのち、別途ターミナル(windowsであればpoweshell)を立ち上げ、SomeOneLetter直下に移動
4. 以下のコマンドを実行(DB作成、パッケージの更新、コンパイル)
   * `docker exec -it someoneletter_app-div_1 sh setup.sh`
5. ブラウザ(Chrome,safari推奨)にて`http://localhost:80`にアクセス
