class UpdateColumnLetters < ActiveRecord::Migration[6.1]
  def change
    change_column_null :letters, :to_user_id, false
  end
end