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
    # 入力情報から@letter、match_roomインスタンスを新規作成
    @letter     = current_user.letters.build(letter_params)
    @match_room = @letter.build_match_room

    # 対象ユーザーを選定(アクティブかつ,ランダム)
    @to_user_id = current_user.calc_to_user_id

    # @inbox_record作成
    @inbox_record = @match_room.inbox_records.build( user_id: @to_user_id, to_user_id: current_user.id)

    # DB保存(@letter,@match_room,@inbox_record)
    @letter.save_safe
    
    # リダイレクト  
    redirect_to request.referrer || root_url
  end

  # POST  /letters/[to_letter_id]/reply
  def reply
    # 入力情報から@letterインスタンス生成
    @letter = current_user.letters.build(letter_params_reply)

    # DB保存
    @letter.save_safe

    # リダイレクト  
    redirect_to request.referrer || root_url
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



private
 
  # Strong Parametes
  def letter_params
    params.require(:letter).permit(:title, :content, :layout_id)
  end

  def letter_params_reply
    params.require(:letter).permit(:title, :content, :layout_id, :match_room_id)
  end
end