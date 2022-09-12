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

    # DELETE /inbox_records/[id]
    def destroy
        @inbox_record = InboxRecord.find(params[:id])
        @inbox_record.hidden_flag = true

        save_safe(@inbox_record,"手紙を破棄しました","不明なエラーです")
        redirect_to inbox_record_url
    end

      # POST /inbox_records/[id]
    def release
        debugger

        @match_room   = find
        
        #自身のinbox_recordを削除
        @inbox_record = @match_room.find
        @inbox_record.destory

        #新たにinbox_recordを追加
        @to_user_id = "".calc_to_user_id
        @match_room.inbox_records.build(user_id: ??, to_user_id: @to_user_id)

        save_safe(@match_room,"成功","失敗")
        redirect_to inbox_record_url
    end


end
