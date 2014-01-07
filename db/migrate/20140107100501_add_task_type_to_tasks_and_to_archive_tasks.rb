class AddTaskTypeToTasksAndToArchiveTasks < ActiveRecord::Migration
  def change
    change_table :tasks do |t|
      t.string   :task_type
      t.text     :special
    end
    change_table :archive_tasks do |t|
      t.string   :task_type
      t.text     :special
    end
  end
end
