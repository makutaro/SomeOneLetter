class CreateLetters < ActiveRecord::Migration[6.1]
  def change
    create_table :letters do |t|
      t.string :title,           null: false, default: ""
      t.text :content,           null: false, default: ""
      t.integer :to_user_id,     null: false
      t.boolean :reply_flag,      null: false, default: false

      # referenceで、自動で外部キーであるuser_idが作られる
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    # 送信済みの手紙を検索する際に利用
    add_index :letters, [:user_id, :created_at]
  end
end
