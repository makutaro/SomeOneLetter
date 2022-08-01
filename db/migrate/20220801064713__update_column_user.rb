class UpdateColumnUser < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :location, :string
    add_column :users, :location, :int
  end
end