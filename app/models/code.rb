class Code < ActiveRecord::Base

  has_one :hold_zone, class_name: 'Zone', foreign_key: 'code_id'
  has_one :hold_task, class_name: 'Task', foreign_key: 'code_id'
  belongs_to :task
  has_many :code_strings

  attr_accessible :info, :ko, :name, :number, :parent_id, :type

  ##
  # Define Zone which this code belongs to.
  # if task_id is null return null, otherwise ask the task about its zone.
  #
  # Returns:
  # - {Zone} Zone if any or nil if this is the multizone code
  def zone
    task.try(:zone)
  end


end
