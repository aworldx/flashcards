class AddAvatarColumnsToCards < ActiveRecord::Migration[5.1]
  def change
    add_attachment :cards, :avatar
  end
end
