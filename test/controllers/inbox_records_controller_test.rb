require "test_helper"

class InboxRecordsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user1 = users(:user_01)
    @user2 = users(:user_02)
    @user3 = users(:user_03)
  end

##############
### index  ###
##############

test "inbox_records-index" do
  # 非ログイン遷移
  get inbox_records_path
  assert_redirected_to new_user_session_path
  # 正常系
  sign_in(@user1)  
  get inbox_records_path
  assert_template 'inbox_records/index'
end

##############
## destroy  ##
##############

test "inbox_records-destroy" do
  # 非ログイン遷移
  delete inbox_record_path(1)
  assert_redirected_to new_user_session_path
  # 正常系
  sign_in(@user2)
  delete inbox_record_path(1) 
  assert flash.to_hash.value? "手紙を破棄しました"
  assert_redirected_to inbox_records_path
  # 自身以外のrecordを指定
  delete inbox_record_path(2)
  assert flash.to_hash.value? "不正なアクセスです"
end

##############
## release  ##
##############

test "inbox_records-release" do
  # 非ログイン遷移
  post release_inbox_records_path, params: { id:1 }
  assert_redirected_to new_user_session_path
  # 正常系
  sign_in(@user2)
  post release_inbox_records_path, params: { id:1 }
  assert flash.to_hash.value? "手紙を海に流しました"
end

end

