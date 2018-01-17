class AddColumnCurrentToDecks < ActiveRecord::Migration[5.1]
  def change
    add_column :decks, :current, :boolean
  end
end
