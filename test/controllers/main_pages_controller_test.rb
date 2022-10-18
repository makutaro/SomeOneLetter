require "test_helper"

class MainPagesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:user_01)
  end

  ############
  ##  top   ##
  ############

  test "main-pages-top" do
    # 非ログイン
    get root_path
    assert_template 'main_pages/top'
    # 正常系
    sign_in(@user)
    get root_path
    assert_redirected_to home_path
  end

  ############
  ##  home  ##
  ############
  
  test "main-pages-home" do
    # 非ログイン
    get home_path
    assert_redirected_to new_user_session_path
    # 正常系
    sign_in(@user)
    get home_path
    assert_template 'main_pages/home'
  end
  
end