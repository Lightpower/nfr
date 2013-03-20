class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :number
      t.string :name
      t.string :data
      t.integer :zone_id
      t.integer :task_id
      t.integer :code_count
      t.integer :bonus

      t.timestamps
    end
  end
end
