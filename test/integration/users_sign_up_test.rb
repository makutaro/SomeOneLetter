require "test_helper"

class UsersSignUpTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user1 = users(:user_01)
    @user2 = users(:user_02)
    @user3 = users(:user_03)
  end

  test "サインアップ => プロフィール編集 => サインアウト" do
    get new_user_session_path
    post new_user_step1_path, params: { 
      user: { email:                 "sample@example.com",
              password:              "makutaro",
              password_confirmation: "makutaro" } }
    assert_template 'devise/registrations/step2'
    assert_difference 'User.count', 1 do  
      post user_registration_path, params: { 
        user: { name:                  "makutaro",
                email:                 "sample@example.com",
                password:              "makutaro",
                password_confirmation: "makutaro",
                like_thing:            "チャーハン",
                location:              "千葉県" } }
    end
  end
  
  # test "invalid signup information" do
  #   get signup_path
  #   assert_no_difference 'User.count' do
  #     post users_path, params: { user: { name:  "",
  #                                         email: "user@invalid",
  #                                         password:              "foo",
  #                                         password_confirmation: "bar" } }
  #   end
  #   assert_template 'users/new'
  #   assert_select 'div#<CSS id for error explanation>'
  #   assert_select 'div.<CSS class for field with error>'
  # end

end
