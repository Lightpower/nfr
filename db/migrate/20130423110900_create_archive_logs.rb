class CreateArchiveLogs < ActiveRecord::Migration
  def change
    create_table :archive_logs do |t|
      t.string  :login,       null: false
      t.string  :data,        null: false
      t.integer :result_code, null: false

      t.references :archive_team
      t.references :archive_code
      t.references :game,         null: false

      t.datetime :created_at
      t.datetime :updated_at
    end

  end
end
