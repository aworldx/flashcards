class RemoveSuccessFailChecksFromCards < ActiveRecord::Migration[5.1]
  def change
    remove_column :cards, :success_checks, :integer
    remove_column :cards, :fail_checks, :integer
  end
end
