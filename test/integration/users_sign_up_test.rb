require "test_helper"

class UsersSignUpTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user1 = users(:user_01)
    @user2 = users(:user_02)
    @user3 = users(:user_03)
  end

  test "サインアップ => プロフィール編集 => サインアウト" do
    #サインアップ_step1
    get new_user_session_path
    post new_user_step1_path, params: { 
      user: { email:                 "sample@example.com",
              password:              "makutaro",
              password_confirmation: "makutaro" } }
    assert_template 'devise/registrations/step2'
    
    #サインアップ_step2
    assert_difference 'User.count', 1 do  
      post user_registration_path, params: { 
        user: { name:                  "makutaro",
                email:                 "sample@example.com",
                password:              "makutaro",
                password_confirmation: "makutaro",
                like_thing:            "チャーハン",
                location:              "千葉県" } }
      assert_redirected_to root_path
    end

    #プロフィール編集
    get edit_user_registration_path
    
  end

end
