class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer  :number
      t.string   :name
      t.string   :task_type
      t.text     :preview
      t.text     :data
      t.text     :special
      t.integer  :code_quota
      t.float    :bonus
      t.integer  :duration

      t.references :zone
      t.references :task
      t.references :code
      t.references :game,   null: false
    end

    add_index :tasks, :zone_id
    add_index :tasks, :task_id
    add_index :tasks, :game_id
  end
end