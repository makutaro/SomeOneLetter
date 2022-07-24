class AddColumnUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :like_thing, :string
    add_column :users, :location, :string
  end
end
