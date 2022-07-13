class ApplicationController < ActionController::Base
   
  # 認証が必要でないページを制御
  before_action :authenticate_user!
  skip_before_action :authenticate_user!, only: [:home]

end
