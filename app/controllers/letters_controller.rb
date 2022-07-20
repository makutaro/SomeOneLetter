class LettersController < ApplicationController

  # GET /letters/new
  def new
    # 投稿form用に空のletterを作成
    @letter = current_user.letters.build
    logger.debug "@letter => #{@letter}"
  end

  # POST  /letters
  def create
    # paramsを基に、letterインスタンスを生成
    @letter = current_user.letters.build(letter_params)
    if @letter.save
      flash[:success] = "投稿しました"
      redirect_to root_url
    else
      render new_letter_path
    end
      

  end

private
  
  # Strong Parametes
  def letter_params
    params.require(:letter).permit(:title, :content)
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
