module ApplicationHelper
  
  def person(value)
      "#{value}人"
  end   

  def background_style
     user_signed_in? ? "body_signed_in" : "body_not_signed"
  end

  # 手紙が自動リリースされるまでの時間を計測
  # 7日-(現在時刻 - 届いた時刻)
  def elapsed_time(t)
    sec = 7 * 86400 - (Time.now - t)
    day = sec.to_i /  86400 
    if day == 0 
      (Time.parse("1/1") + (sec - day * 86400)).strftime("残り%H時間")
    else
      (Time.parse("1/1") + (sec - day * 86400)).strftime("残り#{day}日")
    end
  end
  
end