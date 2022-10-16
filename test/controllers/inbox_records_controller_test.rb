require "test_helper"

class InboxRecordsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user1 = users(:user_01)
    @user2 = users(:user_02)
    @user3 = users(:user_03)
  end

################
## 非ログイン ##
################



##############
### create ###
##############

end

