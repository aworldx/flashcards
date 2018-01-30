class AddColumnDeckToCards < ActiveRecord::Migration[5.1]
  def change
    add_reference :cards, :deck, null: false
    remove_reference :cards, :user
  end
end
