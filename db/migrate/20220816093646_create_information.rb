class CreateInformation < ActiveRecord::Migration[6.1]
  def change
    create_table :information do |t|
      t.string :content,       null: false, default: ""
      t.boolean :hidden_flag,  null: false, default: false

      t.timestamps
    end
  end
end
