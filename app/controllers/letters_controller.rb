class LettersController < ApplicationController
  include LettersHelper

  # GET /letters/new
  def new
    # 投稿form用に空のletterを作成
    @letter = current_user.letters.build
    logger.debug "@letter => #{@letter}"
    # レイアウトの選択肢をhashで作成
    @layout_hash = layout_map
  end

  # POST  /letters
  def create
    # paramsを基に、letterインスタンスを生成
    @letter = current_user.letters.build(letter_params)
    @letter.set_to_user_id
    
    logger.debug("#####################")
    logger.debug("## user_id    => #{@letter.user_id} ##")    
    logger.debug("#####################")
    logger.debug("## to_user_id => #{@letter.to_user_id} ##")
    logger.debug("#####################")
  
    if @letter.save # DBに保存
      flash[:success] = "投稿しました"
      redirect_to root_url
    else # DBエラー
      flash[:danger] = "不明なエラーです"
      redirect_to new_letter_path
    end
  end

private
  
  # Strong Parametes
  def letter_params
    params.require(:letter).permit(:title, :content,:layout_id)
  end
  
  # # 参考
  # def create
  #   # paramsを基に、micropostsインスタンスを生成
  #   @micropost = current_user.microposts.build(micropost_params)
  #   # paramsを基に、imageをmicropostにアタッチ
  #   # attach => インスタンスにオブジェクトを紐づける
  #   @micropost.image.attach(params[:micropost][:image])
  #   # 正常にinsertが処理されたら成功
  #   if @micropost.save
  #     flash[:success] = "Micropost created!"
  #     redirect_to root_url
  #   # 失敗したら(するか？笑)homeに戻る
  #   else
  #     @feed_items = current_user.feed.paginate(page: params[:page])
  #     render 'static_pages/home'
  #     #redirect_to root_url
  #   end
  # end

end
