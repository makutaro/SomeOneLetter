class ApplicationController < ActionController::Base
   
  # 認証が必要でないページを制御(現状topだけ)
  before_action :authenticate_user!,:build_letter
  skip_before_action :authenticate_user!, only: [:top]

  # インスタンスのsaveメソッド
  def save_safe(object,success_msg,error_msg)
    if object.save # 成功
       flash[:success] = success_msg
    else           # 失敗
       flash[:error] = error_msg
      redirect_to request.referrer || root_url
    end
   end

   # 新規送信用の@letter作成
   def build_letter
      @letter_new = current_user.letters.build if user_signed_in?
   end

end
