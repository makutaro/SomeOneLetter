class StaticPagesController < ApplicationController
  def top
    if user_signed_in? 
      redirect_to home_url
    end
  end

  def home
    @information = Information.all
   # @inbox_records_new_count = InboxRecord.find_count_by_new(current_user.id)
  end

  def contact
  end
end
