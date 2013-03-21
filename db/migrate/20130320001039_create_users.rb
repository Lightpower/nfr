class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.references :team

      t.timestamps
    end

    add_index :users, :team_id
  end
end
