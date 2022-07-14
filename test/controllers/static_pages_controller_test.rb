require "test_helper"

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:user_01)
  end

# 画面遷移系
  test "should get home" do
    get root_path
    assert_response :success
  end
  test "should get contact" do
    get contact_path
    assert_response :redirect
    sign_in(@user)
    get contact_path
    assert_response :success
  end
 end