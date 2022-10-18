class MatchRoomsController < ApplicationController
  before_action :collect_room_id, only: [:show]
  
  # GET  /match_rooms/[id]
  def show
    @letters = Letter.find_all_by_id(params[:id])         # 対象roomのlettersを取得
    @inbox_record =InboxRecord.find_by(
      match_room_id: params[:id],
      user_id: current_user.id)
  end

private

  # room_idが正当な値であるかチェック
  def collect_room_id
    unless InboxRecord.where(match_room_id:params[:id]).pluck(:user_id).include?(current_user.id)
        flash[:error] = "不正なアクセスです"
        redirect_to request.referrer || root_url
    end
  end

end
