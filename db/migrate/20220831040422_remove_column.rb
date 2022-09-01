class RemoveColumn < ActiveRecord::Migration[6.1]
  def change
    remove_column :match_rooms, :matched_flag, :boolean
    remove_column :letters, :to_user_id, :int
    remove_column :letters, :reply_flag, :boolean
    
    drop_table :match_room_users
  end
end
