#inbox_record(受信箱に表示されるユーザ情報の一単位 
#  ※lineのトーク画面の1レコードと同じイメージ)
class InboxRecordsController < ApplicationController

    # GET  /inbox_records/[:id]
    def show
        # user_idが自身のinbox_recordを全て取得
        @inbox_records = InboxRecord.find_all_by_id(current_user.id)

    end

    # GET  /inbox_records/room/[id]
    def room
        # 自身のinbox_recordを取得
        @inbox_record = InboxRecord.find_by_id(params[:inbox_id])
        
        # 対象roomのlettersを取得
        @letters = Letter.find_all_by_id(params[:room_id])
        
        # 投稿form用に空のletterを作成
        @letter = current_user.letters.build
    end
end
