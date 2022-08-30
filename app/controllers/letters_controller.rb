class LettersController < ApplicationController

  # GET /letters/new
  def new
    # 投稿form用に空のletterを作成
    @letter = current_user.letters.build
  end

  # GET /letters/[id]
  def show
    @letter = current_user.letters.build(letter_params)
    @letter.created_at = Time.now
  end

  # POST  /letters
  def create 
    # 入力情報から@letterインスタンス生成
    @letter = current_user.letters.build(letter_params)

    # 返信or新規を判定
    if @letter.reply_flag
      # 返信処理
      # match_room_usersを検索し,match_room_idを取得
      find.mat
      # @letterにmatch_room_id付与
    else
      # 新規処理
      @letter.to_user_id = find_randam_user_id
       # match_room,match_room_users(x2)を新規作成
        @match_room = @letter.build_match_room
        @match_room_users = @match_room.match_room_users.build([{ user_id: current_user.id}, { user_id: @letter.to_user_id}])
    end
  
    if @letter.save # DBに保存
      flash[:success] = "投稿しました"
      redirect_to root_url
    else # DBエラー
      flash[:danger] = "DBエラーです"
      redirect_to request.referrer || root_url
    end
  end

  # DELETE /letters/id
  def destroy
    Letter.find(params[:id]).destroy
    flash[:success] = "手紙を削除しました"
    
    # request.referrer => ひとつ前のURLを返す(なければroot)
    redirect_to request.referrer || root_url
  end
 
  # POST /lettter/[letter_id]/release
  def release
    @letter = Letter.find(params[:id])
    # letterカラムの[to_user_id]を切り替える
    # 出来れば流れたcountを計測したい

    @letter.to_user_id = rand(10)+1;
    @letter.save

    flash[:success] = " userid => #{@letter.to_user_id} に手紙を流しました"

    # request.referrer => ひとつ前のURLを返す(なければroot)
    redirect_to request.referrer || root_url
  end

  # POST  /letters/[to_letter_id]/reply
  def reply
  end

  def confirm
  end

private
 
  # Strong Parametes
  def letter_params
    params.require(:letter).permit(:title, :content, :layout_id, :to_user_id)
  end
end

 def find_randam_user_id
  #自分以外のランダムなuser_idを取得
  #今回は仮に"2"を返信
  return 2
 end