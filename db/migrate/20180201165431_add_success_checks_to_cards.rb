class AddSuccessChecksToCards < ActiveRecord::Migration[5.1]
  def change
    add_column :cards, :success_checks, :integer, null: false, default: 0
    add_column :cards, :fail_checks, :integer, null: false, default: 0
  end
end
