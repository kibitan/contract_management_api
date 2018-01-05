class AddAuthTokenToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :token, :string, null: false
    add_index :users, :token, unique: true
  end
end
