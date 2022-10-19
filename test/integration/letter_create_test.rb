require "test_helper"

class LetterCreateTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user2 = users(:user_02)
    @user3 = users(:user_03)
  end

  test "user03_letter返信=>user02_letter返信=>user02_inbox_record非表示=>user03_影響確認" do 
      sign_in(@user3)
      get home_path
      ##返信可能数0##
      sign_in(@user2)
      assert_difference 'Letter.count', 1 do 
        post letters_path, params: { letter: { title: "title", content: "content", match_room_id: 1 } }, xhr: true
      end
      sign_in(@user3)
      get home_path
      #返信可能数1#
      get inbox_records_path  
      # レコード数1#      
  end
end
