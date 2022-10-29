class AddColumnUsersSendableCount < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :sendable_count, :int, null:false, default:10
  end
end
