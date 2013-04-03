class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.string  :login,       null: false
      t.string  :data,        null: false
      t.integer :result_code, null: false

      t.references :team,     null: false
      t.references :code

      t.timestamps
    end

    add_index :logs, :team_id
  end
end
