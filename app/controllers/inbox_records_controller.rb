#inbox_record(受信箱に表示されるユーザ情報の一単位 
#  ※lineのトーク画面の1レコードと同じイメージ)
class InboxRecordsController < ApplicationController

    # GET  /inbox_records/[:id]
    def show
        @inbox_records = InboxRecord.find_all_by_id(current_user.id)                   # 対象レコードを全て取得
        @inbox_records.map {|f| f.ignore_wait_reply_records!}.compact # 返信待ちのレコードを除外
    end

    # GET  /inbox_records/room/[id]
    def room
        collect_room_id?(params[:room_id])                         # room_idが正当な値であるかチェック
        @inbox_record = InboxRecord.find_by_id(params[:inbox_id])  # 自身のinbox_recordを取得
        @letters = Letter.find_all_by_id(params[:room_id])         # 対象roomのlettersを取得
        @letter_reply = current_user.letters.build                 # 投稿form用に空のletterを作成
    end

    # DELETE /inbox_records/[id]
    def destroy
        collect_inbox_record_id?(params[:id])                        # 対象idが自身のものであるかをチェック
        InboxRecord.find(params[:id]).destroy
        flash[:success] = "手紙を破棄しました"
        redirect_to inbox_record_url
    end

    # POST /inbox_records/release
    def release
       collect_inbox_record_id?(params[:my_inbox_id])               # 対象idが自身のものであるかをチェック
       InboxRecord.find(params[:my_inbox_id]).destroy               # 自身のinbox_recordを削除
       to_user_id = User.find_to_user_id(params[:target_user_id])   # 対象ユーザーを選定(アクティブかつ,ランダム)
       @inbox_record = InboxRecord.new(                             # @inbox_record作成
            match_room_id: params[:match_room_id],  
            user_id:       params[:target_user_id], 
            to_user_id:    to_user_id) 
        save_safe(@inbox_record,"手紙を海に流しました","失敗")        # DB保存 
        redirect_to inbox_record_url(current_user.id)
    end

private
  
    # room_idが正当な値であるかチェック
    def collect_room_id?(room_id)
        unless InboxRecord.where(match_room_id:room_id).pluck(:user_id).include?(current_user.id)
            flash[:error] = "不正なアクセスです"
            redirect_to request.referrer || root_url
        end
    end

    # inbox_record_idが自身のuser_idであるかチェック
    def collect_inbox_record_id?(record_id)
        unless InboxRecord.find(record_id).user_id == current_user.id
            flash[:error] = "不正なアクセスです"
            redirect_to request.referrer || root_url
        end
    end

end
