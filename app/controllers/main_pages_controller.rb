class MainPagesController < ApplicationController
  def top
    if user_signed_in? 
      redirect_to home_url
    end
  end

  def home
    @information = Information.all
  end
end