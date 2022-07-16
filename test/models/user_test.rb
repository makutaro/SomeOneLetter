require "test_helper"

class UserTest < ActiveSupport::TestCase
  # devise系のモジュールは今回使用しない為、コメントアウト
  #include Devise::Test::ControllerHelpers

  def setup
    @user = User.new(name: "Example User", email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar")
  end

# validate

  test "valid_success" do
    assert @user.valid?  # 正常
  end

  test "name_valid" do
    @user.name = "     "
    assert_not @user.valid?  # 空白
    @user.name = "a" * 21   
    assert_not @user.valid?  # 21文字以上
    @user.name = "a" * 3
    assert_not @user.valid?  # 3文字以下 
  end

  test "email_valid" do
    @user.email = "     "
    assert_not @user.valid? # 空白
    @user.email = ""        
    assert_not @user.valid? # 値なし
    #有効アドレス群
    valid_addresses = %w[ user@example.com 
                          USER@foo.COM 
                          A_US-ER@foo.bar.org
                          first.last@foo.jp 
                          alice+bob@baz.cn]
    # 無効アドレス群
    invalid_addresses = %w[ user@example,com 
                            user_at_foo.org 
                            user.name@example.
                            foo@bar_baz.com 
                            foo@bar+baz.com]               
    #チェック実施
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end
  
  test "password_valid" do
    @user.password              = "a" * 5  
    @user.password_confirmation = "a" * 5
    assert_not @user.valid?                # 6文字未満
    @user.password              = "a" * 6  
    @user.password_confirmation = "b" * 6
    assert_not @user.valid?                # 2値間の齟齬
  end

# unique_column

  test "name_unique" do
    @user2 = User.new(name: "Example User", email: "user2@example.com",
    password: "foobar", password_confirmation: "foobar")
    @user2.save
    assert_not @user.valid? # name重複
  end

  test "email_unique" do
    @user2 = User.new(name: "Example User2", email: "user@example.com",
    password: "foobar", password_confirmation: "foobar")
    @user2.save
    assert_not @user.valid? # email重複
  end
  

    
end
