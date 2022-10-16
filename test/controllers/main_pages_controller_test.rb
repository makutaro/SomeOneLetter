require "test_helper"

class MainPagesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:user_01)
  end

# 画面遷移系
  test "main-pages-非ログイン遷移" do
    get root_path
    assert_response :success
    get home_path
    assert_redirected_to new_user_session_path
  end

  test "main-page0s-ログイン済み遷移" do
    sign_in(@user)
    get root_path
    assert_redirected_to home_path
    get home_path
    assert_response :success
  end
 end