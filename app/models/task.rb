class Task < ActiveRecord::Base

  belongs_to :zone
  belongs_to :task, class_name: "Task", foreign_key: task_id
  has_many   :tasks, class_name: "Task", foreign_key: task_id
  has_many   :hints

  attr_accessible :bonus, :code_quota, :data, :name, :number, :duration, :task, :task_id, :zone, :zone_id
end
