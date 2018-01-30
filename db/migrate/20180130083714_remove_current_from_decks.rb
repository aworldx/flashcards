class RemoveCurrentFromDecks < ActiveRecord::Migration[5.1]
  def change
    remove_column :decks, :current, :bool
  end
end
