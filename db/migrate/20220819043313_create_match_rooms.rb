class CreateMatchRooms < ActiveRecord::Migration[6.1]
  def change

    create_table :match_rooms do |t|
      t.boolean :matched_flag,         null:false, default: false
      t.timestamps
    end

    create_table :match_room_users do |t|
      t.references :match_room,   foreign_key: true # match_room.id への外部キー制約
      t.references :user,         foreign_key: true
      t.boolean    :hidden_flag,  null:false, default: false
      t.timestamps
    end
    add_reference :letters, :match_room, null: false, foreign_key: true     # match_room.id への外部キー制約
  end
end
