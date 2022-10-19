require "test_helper"

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  
  ##############
  ### step1  ###
  ##############

  test "registration-step1" do
    # 正常系
    post new_user_step1_path, params: { 
      user: { email:                 "sample@example.com",
              password:              "makutaro",
              password_confirmation: "makutaro" } }
    assert_template 'devise/registrations/step2'
    # 異常系
    post new_user_step1_path, params: { 
      user: { email:                 "invalid@example",
              password:              "makutaro",
              password_confirmation: "makutaro" } }
    assert_template 'devise/registrations/new'
  end

  ##############
  ### create ###
  ##############

  test "registration-create" do  
    # 異常系
    assert_no_difference 'User.count' do
      post user_registration_path, params: { 
        user: { name:                  "makutaro",
                email:                 "sample@example.com",
                password:              "makutaro",
                password_confirmation: "makutaro",
                like_thing:            "",
                location:              "千葉県" } }
      assert_template 'devise/registrations/step2'
    end
    # 正常系
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
  end
end