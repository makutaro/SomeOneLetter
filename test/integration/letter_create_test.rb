require "test_helper"

class LetterCreateTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user2 = users(:user_02)
    @user3 = users(:user_03)
  end

  test "user03_letter返信=>user02_letter返信=>user02_inbox_record非表示=>影響確認" do 
    # user2 なにもしない
      sign_in(@user2)
      get inbox_records_path 
       assert_select "div.inbox-record", 1       # レコード数1
       assert_select "span.replyable-tag", 0     # 返信可能タグ数1
      
    # user3 返信x2 => 二回目エラー
      sign_in(@user3)
      get inbox_records_path  
       assert_select "div.inbox-record", 1       # レコード数1
       assert_select "span.replyable-tag", 1     # 返信可能タグ数1
      get match_room_path(1)
       assert_difference 'Letter.count', 1 do 
        post letters_path, params: { letter: { title: "title", content: "content", match_room_id: 1 } }, xhr: true
       end
       assert_difference 'Letter.count', 0 do 
        post letters_path, params: { letter: { title: "title", content: "content", match_room_id: 1 } }, xhr: true
        assert flash.to_hash.value? "不正なアクセスです"
       end

    # user2 返信 => 破棄
      sign_in(@user2)
      get inbox_records_path
       assert_select "div.inbox-record", 1       # レコード数1
       assert_select "span.replyable-tag", 1     # 返信可能タグ数1
      get match_room_path(1)
       assert_difference 'Letter.count', 1 do 
         post letters_path, params: { letter: { title: "title", content: "content", match_room_id: 1 } }, xhr: true
       end
       assert_difference 'InboxRecord.count', -1 do 
        delete inbox_record_path(1)
        assert flash.to_hash.value? "手紙を破棄しました"
       end
      get inbox_records_path  
       assert_select "div.inbox-record", 0       # レコード数0

    # user3 返信(相手は削除したが、返信は可能)
      sign_in(@user3)
      get inbox_records_path  
      assert_select "div.inbox-record", 1       # レコード数1
      assert_difference 'Letter.count', 1 do 
        post letters_path, params: { letter: { title: "title", content: "content", match_room_id: 1 } }, xhr: true
      end

    # user2 削除したため、レコードなし
      sign_in(@user2)
      get inbox_records_path  
      assert_select "div.inbox-record", 0       # レコード数0

  end
end
