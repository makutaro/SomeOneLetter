class AddColumnLetters < ActiveRecord::Migration[6.1]
  def change
    add_column :letters, :layout_id, :integer, null:false
  end
end
