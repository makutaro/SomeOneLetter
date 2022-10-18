#inbox_record(受信箱に表示されるユーザ情報の一単位 
#  ※lineのトーク画面の1レコードと同じイメージ)
class InboxRecordsController < ApplicationController
     before_action :collect_inbox_record_id, only: [:destroy,:release]

    # GET  /inbox_records
    def index
        @inbox_records = InboxRecord.find_all_by_id(current_user.id)  # 対象レコードを全て取得
        @inbox_records.map {|f| f.ignore_wait_reply_records!}.compact # 返信待ちのレコードを除外
    end

    # DELETE /inbox_records/[id]
    def destroy
        InboxRecord.find(params[:id]).destroy
        flash[:success] = "手紙を破棄しました"
        redirect_to inbox_records_url
    end

    # POST /inbox_records/release
    def release
        @inbox_record = InboxRecord.find(params[:id])
        to_user_id = User.find_to_user_id(@inbox_record.to_user_id)   # 対象ユーザーを選定(アクティブかつ,ランダム)
        @inbox_record.destroy                                        # 自身のinbox_recordを削除
        @new_inbox_record = InboxRecord.new(                             # @inbox_record作成
            match_room_id: @inbox_record.match_room_id,  
            user_id:       @inbox_record.to_user_id, 
            to_user_id:    to_user_id) 
            save_safe(@new_inbox_record,"手紙を海に流しました","不明なエラーです")        # DB保存 
            redirect_to inbox_records_url
    end

private
  
    # inbox_record_idが自身のuser_idであるかチェック
    def collect_inbox_record_id
        unless InboxRecord.find(params[:id]).user_id == current_user.id
          flash[:error] = "不正なアクセスです"
          redirect_to request.referrer || root_url
        end
    end

end
