require "test_helper"

class LetterCreateTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user2 = users(:user_02)
    @user3 = users(:user_03)
  end

  test "user03_letter返信=>user02_letter返信=>user02_inbox_record非表示=>user03_影響確認" do 
      sign_in(@user2)
      # get home_path
      #  assert_select "replayavle-count", 0       # 返信可能数0
      get inbox_records_path 
       assert_select "div.inbox-record", 1       # レコード数1
       assert_select "span.replyable-tag", 0     # 返信可能タグ数1
      
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
      end
      # レコード数1#  

      # sign_in(@user2)
      # get home_path
      # #返信可能数1#
      # get inbox_records_path  
      # # レコード数1#
      # delete inbox_record_path(1)
      # assert flash.to_hash.value? "手紙を破棄しました"
      # get inbox_records_path  
      # # レコード数0#

      # sign_in(@user3)
      # get inbox_records_path  
      # # レコード数1#  
  end
end
