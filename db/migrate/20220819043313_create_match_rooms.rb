class CreateMatchRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :match_rooms do |t|
      t.integer :sender_id,            null: false
      t.integer :receiver_id,          null: false
      t.boolean :sender_hidden_flag,   null:false, default: false
      t.boolean :receiver_hidden_flag, null:false, default: false
      t.boolean :matched_flag,         null:false, default: false
      t.timestamps
    end
    add_reference :letters, :match_room, null: false, foreign_key: true
    
    add_index :match_rooms, :sender_id
    add_index :match_rooms, :receiver_id
  end
end
