class Task < ActiveRecord::Base

  belongs_to :zone
  belongs_to :parent_task, class_name: 'Task', foreign_key: 'task_id'
  belongs_to :access_code, class_name: 'Code', foreign_key: 'code_id'
  has_many   :tasks
  has_many   :hints
  has_many   :codes

  attr_accessible :bonus, :code_quota, :data, :name, :number, :duration, :task, :task_id, :zone, :zone_id,
                  :access_code, :code_id
end
