class UsersController < ApplicationController  
  # ログイン状況は継承元で実装済み
  # 正しいユーザであることを確認 
  before_action :correct_user,   only: [:inbox]

    # GET  /users/[match_room_id]/match_room
    def match_room
      @letters = Letter.where(match_room_id: params[:id])
      
       # 投稿form用に空のletterを作成
      @letter = current_user.letters.build
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