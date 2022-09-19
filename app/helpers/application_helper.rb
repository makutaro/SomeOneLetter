module ApplicationHelper
  
  def person(value)
      "#{value}人"
  end   

  def background_style
     user_signed_in? ? "body_signed_in" : "body_not_signed"
  end
  
end