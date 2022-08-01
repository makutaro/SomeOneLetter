class UsersLocationLikeThing < ActiveRecord::Migration[6.1]
  def change
      remove_column :users, :location
      add_column :users, :location, :int, null: false
  
      remove_column :users, :like_thing
      add_column :users, :like_thing, :string, null: false
  end
end
