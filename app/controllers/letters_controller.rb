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
      # @letterにmatch_room_id付与
    else
      # 新規処理
      @letter.to_user_id = rand(10)+1;
       # match_room作成
       # @letterにmatch_room_id付与
       # match_room_users作成x2 
    end
  
    if @letter.save # DBに保存
      flash[:success] = "投稿しました"
      redirect_to root_url
    else # DBエラー
      flash[:danger] = "不明なエラーです"
      redirect_to new_letter_path
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

  # get  /letters/[to_letter_id]/reply
  def reply
    @letter = current_user.letters.build
    # to_letter_id をもとに@letterを作成
    @from_letter = Letter.find(params[:id])
  end

  def confirm
    debugger
  end

private
 
  # Strong Parametes
  def letter_params
    params.require(:letter).permit(:title, :content, :reply_flag, :layout_id, :to_user_id)
  end
end
