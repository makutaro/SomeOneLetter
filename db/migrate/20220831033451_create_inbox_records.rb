class CreateInboxRecords < ActiveRecord::Migration[6.1]
  def change
    create_table :inbox_records do |t|
      t.references :user,       foreign_key: true
      t.references :match_room, foreign_key: true
      t.references :to_user
      t.boolean :hidden_flag,   null: false, default: false
      t.timestamps
    end
    add_foreign_key :inbox_records, :users, name: :to_user_id
  end
end
