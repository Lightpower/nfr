class Task < ActiveRecord::Base
  attr_accessible :bonus, :code_count, :data, :name, :number, :task_id, :zone_id
end
