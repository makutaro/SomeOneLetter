class UsersController < ApplicationController  
  # ログイン状況は継承元で実装済み
  # 正しいユーザであることを確認 
  before_action :correct_user,   only: [:inbox]

   ###################   
   # beforeアクション#
   ###################
   
private
    # 正しいユーザーかどうか確認
    def correct_user
      if current_user.id != params[:id] .to_i
        flash[:danger] = "不正なURLです"
        redirect_to root_url
      end
    end
end