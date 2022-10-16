class MatchRoomsController < ApplicationController  
  # GET  /match_room/[id]
  def show
    collect_room_id?(params[:room_id])                         # room_idが正当な値であるかチェック
    @letters = Letter.find_all_by_id(params[:room_id])         # 対象roomのlettersを取得
    @inbox_record.InboxRecord.where(match_room_id: params[:room_id],user_id: current_user.id)
  end

private

  # room_idが正当な値であるかチェック
  def collect_room_id?(room_id)
    unless InboxRecord.where(match_room_id:room_id).pluck(:user_id).include?(current_user.id)
        flash[:error] = "不正なアクセスです"
        redirect_to request.referrer || root_url
    end
  end

end