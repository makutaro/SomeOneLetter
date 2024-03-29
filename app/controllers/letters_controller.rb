class LettersController < ApplicationController

  # POST  /letters ※Ajax
  def create 
    @letter = current_user.letters.build(letter_params)                     # @letter作成　※ストパラ
    @letter.match_room_id ? create_reply_letter : create_new_letter         # match_room_id あり => 返信処理  => 新規処理
  end

private
 
  # Strong Parametes
  def letter_params
    params.require(:letter).permit(:title, :content, :match_room_id)
  end

  def create_new_letter
    @type = "new"
    to_user_id = User.find_to_user_id(current_user.id)                                      # 対象ユーザーを選定(アクティブかつ,ランダム)
      @match_room = @letter.build_match_room                                                # @match_room作成
        @match_room.inbox_records.build(user_id: current_user.id, to_user_id: to_user_id)   # @inbox_record作成(自身と相手)
        @match_room.inbox_records.build(user_id: to_user_id, to_user_id: current_user.id)
      save_safe(@letter,"投稿しました","不明なエラーです")                                   # DB保存(@letter,@match_room,@inbox_record)
      current_user.reduce_sendable_count!                                                 # userのsendable_countを1減らす
      flash[:info] = "「#{User.find(to_user_id).like_thing}」が好きな人のもとに届いた気がする"
  end

  def create_reply_letter
    if collect_room_id?(@letter.match_room_id)
      @type = "reply"
      @letter.match_room.inbox_records.map{|f| f.touch}              # inbox_recordのtimestamp更新
      save_safe(@letter,"返信しました","不明なエラーです")             # DB保存(@letter,@match_room,@inbox_record)  
    else
      flash[:error] = "不正なアクセスです"
      return redirect_to request.referrer || root_url
    end
  end

  #room_idが正当な値(返信可能な状態)であるかチェック
  def collect_room_id?(room_id)
    InboxRecord.where(match_room_id:room_id).pluck(:user_id).include?(current_user.id) && # room_idに自身が所属している
    @letter.match_room.last_letter.user_id != @letter.user_id                             # room_idの最期の手紙が自分でない
  end

end