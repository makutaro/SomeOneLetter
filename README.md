# SomeOneLetter

## 概要
* SomeOneLetterは、手紙を瓶に詰めて海に流す営みから着想を得た`世界一気軽なマッチング型文通サービス` です。<br>
  * あなたが手紙を海に流すと、その手紙がアクティブなユーザの誰かのもとに流れ着きます。(送信)<br>
  * 同様に、誰かから届いたの手紙を確認し、その手紙の送り主に返信することができます。(返信)<br>
  * 返信は確実に相手のもとへ届き、継続的に文通を行う事ができます。あとはごゆっくり。(マッチング)<br>

## 開発意図
本サービスの開発意図は主に以下の二点です。<br>
* 「ECサイト」「twitter_likeなSNS」「一般的なマッチングアプリ」のような、開発ノウハウが確立されているものではなく、<br>
DB設計やドメインの振る舞いを1から検討されたサービスでないと、ポートフォリオとしての価値が保証できないと考えたため。<br>

* twitterやfacebookのような「フォロワーが多い人ほど声が大きくなる」性質があり、<br>コミュニケーションSNSのアンチテーゼとして、`総理大臣も小学生でも、完全に平等にコミュニケーションを行えるSNS`を作ってみたいと考えたため。<br>

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
  * nginx
  * Docker / Docker-compose
  * AWS (ECS / Fargate / RDS / S3 / VPC / IAM / Route53 / ACM / ALB ) 
  * CircleCI
  * Postgres / Puma / Nginx
* 今後実装予定
  * テストコード改修 minitest => Rspec (実施中)
  * terraformインフラのコード化
  * Next.jsによフロントエンドの完全SPA化

## 拘り
* スマホ操作を想定したUI設計。レスポンシブデザイン対応。
* ユーザーのactive機能、7日間の手紙の保留による自動リリース機能など、手紙の循環を促す機能の実装
* nginx + rails + RDS　によるWeb3層アーキテクチャの実現
* ECS + Fargate によるインフラの完全サーバレス可による運用コストへのアプローチ
* AutoScaling、冗長構成(単一障害点なし)、負荷分散、商用運用を想定した可用性、保守性へのアプローチ

## ER図
![ER図 (1)](https://user-images.githubusercontent.com/92739738/200107036-e8f89dc6-b332-4717-9833-e356d2178311.png)

## インフラ構成図
![aws_infra](https://user-images.githubusercontent.com/92739738/200003088-5a49d90a-51e2-4612-aa30-ddc785100445.png)

## 機能一覧
 * 新規登録、ログイン機能
 * プロフィール編集機能
 * 手紙の閲覧機能