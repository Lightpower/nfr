class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string  :username
      t.string  :role
      t.string  :avatar_url
      t.float   :account, default: 0
      t.integer :level

      t.references :team

      t.timestamps
    end

    add_index :users, :team_id
    add_index :users, :username, unique: true
    add_index :users, :role
  end
end