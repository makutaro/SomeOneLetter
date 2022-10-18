# 【rails + minitest】 flashに格納したメッセージをassertする方法

## 概要
minitestを用いてrailsのテストを記述していてふと、
「flashの内容でコードの挙動を確認出来れば、testコードの可読性があがりスマートなのでは？🤔」と思ったので、書き方をメモします。

## 結論
以下のように記載すればOK。

    assert flash.to_hash.value? "想定されるメッセージ"

## 詳細
Flashクラスはよくわからないので、`to_hash`でハッシュに変換したのち、`value?`メソッドで格納されたメッセージを検索してます。

これを使えば、以下のように、テストコードの可読性がグンッと上がって幸せ

```ruby:sample-test
test "records-destroy" do
# 正常系
  sign_in(@user2) 
  delete record_path(1) 
  assert flash.to_hash.value? "レコードを破棄しました"
  # ↑ 一目瞭然
  assert_redirected_to records_path

# 異常系
  delete record_path(2)
  assert flash.to_hash.value? "不正なアクセスです"
  # ↑ 一目瞭然
end
```
 以上。初学者なので、突っ込みあればコメントくださいませ。
