class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :number
      t.string :name
      t.text :data
      t.integer :code_quota
      t.float :bonus
      t.integer :duration

      t.references :zone
      t.references :task
      t.references :code
    end

    add_index :tasks, :zone_id
    add_index :tasks, :task_id
  end
end
