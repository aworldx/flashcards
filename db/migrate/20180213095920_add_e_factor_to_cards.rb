class AddEFactorToCards < ActiveRecord::Migration[5.1]
  def change
    add_column :cards, :e_factor, :float, null: false, default: 2.5
  end
end
