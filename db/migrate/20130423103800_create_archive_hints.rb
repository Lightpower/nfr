class CreateArchiveHints < ActiveRecord::Migration
  def change
    create_table :archive_hints do |t|
      t.integer :number, null: false
      t.text    :data
      t.integer :delay
      t.float   :cost

      t.references :archive_task
      t.references :game, null: false
    end

  end
end
