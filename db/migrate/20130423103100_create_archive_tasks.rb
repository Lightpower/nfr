class CreateArchiveTasks < ActiveRecord::Migration
  def change
    create_table :archive_tasks do |t|
      t.integer  :number
      t.string   :name
      t.text     :preview
      t.text     :data
      t.integer  :code_quota
      t.float    :bonus
      t.integer  :duration

      t.references :archive_zone
      t.references :archive_task
      t.references :archive_code
      t.references :game, null: false
    end
  end
end
