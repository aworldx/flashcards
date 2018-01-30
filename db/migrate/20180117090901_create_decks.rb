class CreateDecks < ActiveRecord::Migration[5.1]
  def change
    create_table :decks do |t|
      t.string :title
      t.belongs_to :user, index: true, null: false

      t.timestamps
    end
  end
end
