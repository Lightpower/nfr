class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.integer :team_id
      t.integer :user_id
      t.string :data

      t.timestamps
    end
  end
end
