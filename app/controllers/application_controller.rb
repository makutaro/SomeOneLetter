class ApplicationController < ActionController::Base
   
  # 認証が必要でないページを制御(現状homeだけ)
  before_action :authenticate_user!
  skip_before_action :authenticate_user!, only: [:home]

end
