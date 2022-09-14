class LettersController < ApplicationController

  # GET /letters/new
  def new
    # 投稿form用に空のletterを作成
    @letter = current_user.letters.build
  end

  # GET /letters/[id] ※Ajax
  def show
    @letter = current_user.letters.build(letter_params)
    @letter.created_at = Time.now
  end

  # POST  /letters
  def create 
      to_user_id = User.find_to_user_id(current_user.id)                                    # 対象ユーザーを選定(アクティブかつ,ランダム)
      @letter = current_user.letters.build(letter_params)                                   # @letter作成
        @match_room = @letter.build_match_room                                              # @match_room作成
          @match_room.inbox_records.build(user_id: current_user.id, to_user_id: to_user_id) # @inbox_record作成(自身と相手)
          @match_room.inbox_records.build(user_id: to_user_id, to_user_id: current_user.id)
       save_safe(@letter,"投稿しました","不明なエラーです")                                    # DB保存(@letter,@match_room,@inbox_record)
  end

  # POST  /letters/[to_letter_id]/reply
  def reply
      @letter = current_user.letters.build(letter_params_reply) # 入力情報から@letterインスタンス生成
      save_safe(@letter,"投稿しました","不明なエラーです")        # DB保存
  end

  # DELETE /letters/id
  def destroy
      Letter.find(params[:id]).destroy
      flash[:success] = "手紙を破棄しました"
      redirect_to request.referrer || root_url
  end

private
 
  # Strong Parametes
  def letter_params
    params.require(:letter).permit(:title, :content)
  end

  def letter_params_reply
    params.require(:letter).permit(:title, :content, :match_room_id)
  end


end