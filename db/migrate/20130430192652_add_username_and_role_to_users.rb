class AddUsernameAndRoleToUsers < ActiveRecord::Migration
  def change
    add_column :users, :username, :string
    add_column :users, :role, :string

    add_index :users, :username, uniq: true
    add_index :users, :role
  end
end
