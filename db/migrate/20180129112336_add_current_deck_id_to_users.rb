class AddCurrentDeckIdToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :current_deck_id, :bigint
  end
end
