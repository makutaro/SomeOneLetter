require "test_helper"

class UsersSignUpTest < ActionDispatch::IntegrationTest

  test "サインアップ=>プロフィール編集=>サインアウト=>サインイン=>退会処理" do
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
    assert_template 'devise/registrations/edit'
    put user_registration_path, params: { 
      user: { name:                  "makutaro2",
              email:                 "sample@example.com",
              password:              "makutaro2",
              password_confirmation: "makutaro2",
              like_thing:            "ラーメン",
              location:              "埼玉県",
              current_password:      "makutaro" } }
    assert flash.to_hash.value? "アカウント情報を変更しました。"
    assert_redirected_to root_path

    #ログアウト
    delete destroy_user_session_path
    assert flash.to_hash.value? "ログアウトしました。"
    assert_redirected_to root_path

    #サインイン
    get new_user_session_path
    post user_session_path, params: { 
      user: { email:                 "sample@example.com",
              password:              "makutaro2",
              remember_me:           "0" } }
    assert flash.to_hash.value? "ログインしました。"

    #退会処理
    assert_difference 'User.count', -1 do  
      delete user_registration_path
      assert flash.to_hash.value? "アカウントを削除しました。またのご利用をお待ちしております。"
      assert_redirected_to root_path
    end
  end
end

