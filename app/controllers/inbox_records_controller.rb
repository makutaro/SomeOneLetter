#inbox_record(受信箱に表示されるユーザ情報の一単位 
#  ※lineのトーク画面の1レコードと同じイメージ)
class InboxRecordsController < ApplicationController

    def show
        # user_idが自身のinbox_recordを全て取得 
        @inbox_records = InboxRecord.where(user_id: params[:id])

    end
end
