class TaskCode < Code

  belongs_to :task, foreign_key: :parent_id

  attr_accessible :info, :ko, :name, :number, :parent_id
end
