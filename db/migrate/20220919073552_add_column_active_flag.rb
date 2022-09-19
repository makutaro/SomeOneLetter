class AddColumnActiveFlag < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :active_flag, :boolean, null:false, default: true
  end
end
