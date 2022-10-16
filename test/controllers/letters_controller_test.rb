require "test_helper"

class LettersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user1 = users(:user_01)
    @user2 = users(:user_02)
    @user3 = users(:user_03)
  end

################
## 非ログイン ##
################

  test "letter-非ログイン遷移" do
    post letters_path, params: { letter: { title: "title", content: "content" } }
    assert_redirected_to new_user_session_path
  end

##############
### create ###
##############

  test "lettere-create-正常系-new" do
    sign_in(@user1)     
    post letters_path, params: { letter: { title: "title", content: "content" } }, xhr: true
    assert_response :success
  end   

  test "letter-create-正常系-reply" do
    sign_in(@user3)
    post letters_path, params: { letter: { title: "title", content: "content", match_room_id: 1 } }, xhr: true
    assert_response :success
  end  
end
