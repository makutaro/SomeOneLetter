class UsersController < ApplicationController  
  # ログイン状況は継承元で実装済み
  # 正しいユーザであることを確認 
  before_action :correct_user,   only: [:inbox]

    # GET  /users/:id/inbox 
    def inbox
        # @user = User.find(params[:id])
        @receive_letters = Letter.where(to_user_id: params[:id])
        @send_letters    = Letter.where(user_id: params[:id])

        logger.debug("#####################")
        logger.debug("## @receive_letters    => #{@receive_letters.first} ##")    
        logger.debug("#####################")
        logger.debug("## @send_letters    => #{@send_letters.first} ##")
        logger.debug("#####################")

    end


   ###################   
   # beforeアクション#
   ###################
   
    # 正しいユーザーかどうか確認
    def correct_user
      if current_user.id != params[:id] .to_i
        flash[:danger] = "不正なURLです"
        redirect_to(root_url)
      end
    end
end