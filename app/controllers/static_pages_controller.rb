class StaticPagesController < ApplicationController
  def home
    @information = Information.all
    if user_signed_in? 
        # 投稿form用に空のletterを作成
        @letter = current_user.letters.build
    end
  end

  def contact
  end
  
end
