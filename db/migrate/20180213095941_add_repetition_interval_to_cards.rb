class AddRepetitionIntervalToCards < ActiveRecord::Migration[5.1]
  def change
    add_column :cards, :repetition_interval, :integer, null: false, default: 0
  end
end
