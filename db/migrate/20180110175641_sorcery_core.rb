class SorceryCore < ActiveRecord::Migration[5.1]
  def change
    def up
      change_column :users, :email, :string
    end

    def down
      change_column :users, :email, :string, null: false
      add_column :users, :crypted_password, :string
      add_column :users, :salt, :string
      add_index :users, :email, unique: true
    end
  end
end
