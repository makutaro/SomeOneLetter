require "test_helper"

class LetterTest < ActiveSupport::TestCase

  def setup
    @user_01 = users(:user_01)
    @user_02 = users(:user_02)
    @letter_01_01 = @user_01.letters.build(title:   "手紙_1",
                                           content: "user_01です",
                                           to_user_id: @user_02.id)
  end

# validate

  test "valid_success" do
    assert @letter_01_01.valid?  # 正常
    assert @user_01.id == @letter_01_01.user_id #正常
    assert @letter_01_01.to_user_id == @user_02.id 
  end

  test "title_valid" do
    @letter_01_01.title = ""
    assert_not @letter_01_01.valid?
    @letter_01_01.title = "a" * 21  # 21字以上
    assert_not @letter_01_01.valid?

  end

  test "content_valid" do
    @letter_01_01.title = ""
    assert_not @letter_01_01.valid?
    @letter_01_01.title = "a" * 301  # 301字以上
    assert_not @letter_01_01.valid?
  end
end
