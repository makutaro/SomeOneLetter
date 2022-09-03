class RemoveColumnLetters < ActiveRecord::Migration[6.1]
  def change
    remove_column :letters, :layout_id
  end
end
