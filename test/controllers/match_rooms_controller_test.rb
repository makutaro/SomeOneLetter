require "test_helper"

class MatchRoomsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  
  setup do
    @user1 = users(:user_01)
    @user2 = users(:user_02)
    @user3 = users(:user_03)
  end

##############
### index  ###
##############

  test "match_rooms-show" do
    # 非ログイン遷移
    get match_room_path(1)
    assert_redirected_to new_user_session_path
    # 正常系
    sign_in(@user2)  
    get match_room_path(1)
    assert_template 'match_rooms/show'
    sign_out(@user2)
    sign_in(@user1)
    get match_room_path(1)
    assert flash.to_hash.value? "不正なアクセスです"
  end

end
