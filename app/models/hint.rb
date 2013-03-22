class Hint < ActiveRecord::Base

  belongs_to :task

  attr_accessible :cost, :data, :delay, :number, :task, :task_id
end
