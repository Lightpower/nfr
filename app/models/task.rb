# encoding: UTF-8
class Task < ActiveRecord::Base

  belongs_to :zone
  belongs_to :parent_task, class_name: 'Task', foreign_key: 'task_id'
  belongs_to :access_code, class_name: 'Code', foreign_key: 'code_id'
  has_many   :tasks
  has_many   :hints
  has_many   :codes

  attr_accessible :bonus, :code_quota, :preview, :data, :name, :number, :duration, :task, :task_id, :zone, :zone_id,
                  :access_code, :code_id, :bonus


  class << self

    ##
    # Ordering by number
    #
    def by_order
      order('tasks.number')
    end
  end

  ##
  # Generate code number
  #
  def new_code_number
    codes.size + 1
  end

  ##
  # Is the task available for defined user's team
  #
  def is_available?(user)
    return false if user.blank? || user.team.blank?
    return true if self.zone.blank?
    if user.team.zones.include?(self.zone)
      self.access_code.blank? || TeamCode.where(team_id: user.team.id, code_id: self.access_code.id).present?
    else
      false
    end
  end

  ##
  # List of hints which are bought by defined team
  #
  def hints_of(team)
    TeamHint.includes(:hint).where("team_hints.team_id = ? and hints.task_id = ?", team.id, self.id).order("hints.number").map(&:hint)
  end
end
