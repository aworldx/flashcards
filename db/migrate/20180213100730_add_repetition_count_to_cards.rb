class AddRepetitionCountToCards < ActiveRecord::Migration[5.1]
  def change
    add_column :cards, :repetition_count, :integer, null: false, default: 0
  end
end
