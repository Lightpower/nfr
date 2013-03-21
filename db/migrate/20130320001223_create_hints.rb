class CreateHints < ActiveRecord::Migration
  def change
    create_table :hints do |t|
      t.integer :number, null: false
      t.text :data
      t.integer :delay
      t.float :cost

      t.references :task, null: false
    end

    add_index :hints, :number
    add_index :hints, :task_id
    add_index :hints, [:number, :task_id], unique: true
  end
end
