require "test_helper"
class LetterTest < ActiveSupport::TestCase

  def setup
    @user_01 = users(:user_01)
    @user_02 = users(:user_02)
    @letter_01_01 = @user_01.letters.build(
      title:         "正常なタイトル",
      content:       "正常な本文",
      match_room_id: 1)  #match_room_idはdammy
  end

# validate

  test "letter_valid成功チェック" do  
    assert @letter_01_01.valid?                    # 正常
    assert @user_01.id == @letter_01_01.user_id    # 正常
  end

  test "letter_title_validエラーチェック" do
    @letter_01_01.title = ""          # タイトル空白 
    assert_not @letter_01_01.valid?   # validエラー
    @letter_01_01.title = "a" * 21    # 21字以上
    assert_not @letter_01_01.valid?   # validエラー

  end

  test "letter_content_valid_エラーチェック" do
    @letter_01_01.title = ""         #content空白
    assert_not @letter_01_01.valid?  # validエラー
    @letter_01_01.title = "a" * 301  # 301字以上
    assert_not @letter_01_01.valid?  # validエラー
  end
end
