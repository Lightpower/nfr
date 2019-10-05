# encoding: UTF-8
class Task < ActiveRecord::Base

  belongs_to :zone
  belongs_to :parent_task, class_name: 'Task', foreign_key: 'task_id'
  belongs_to :access_code, class_name: 'Code', foreign_key: 'code_id'
  belongs_to :game
  has_many   :tasks
  has_many   :hints
  has_many   :codes

  # TODO: change attr_accessible for new rains
  # attr_accessible :game, :game_id, :bonus, :code_quota, :preview, :data, :name, :number, :duration, :task, :task_id, :zone, :zone_id,
  #               :access_code, :code_id, :bonus, :task_type, :special


  class << self

    ##
    # Ordering by number
    #
    def by_order
      order('tasks.number')
    end

    ##
    # Free tasks
    #
    def unzoned
      where(zone_id: nil)
    end

    def unincluded
      where(task_id: nil)
    end
  end

  ##
  # Generate code number
  #
  def new_code_number
    codes.size + 1
  end

  ##
  # Is the task available for defined team
  #
  def is_available?(team)
    return false if team.blank?
    return false if (self.zone.present? && !team.zones.include?(self.zone))

    # Is current task accessible?
    result = self.access_code.blank? || TeamCode.where(team_id: team.id, code_id: self.access_code.id).present?
    # Is parent task (and all its parent tasks) accessible?
    result &&= (self.task_id.blank? || self.parent_task.is_available?(team))

    result
  end

  ##
  # If task is finished (necessary codes are passed)
  # Task can be finished by all necessary codes passing and all included tasks finishing or by duration ending
  #
  def is_finished?(team)
    return false if team.blank?

    # Code quota passed
    codes_quota = self.code_quota || self.codes.size
    is_finished_by_codes = passed_code_count(team) >= codes_quota
    is_finished_by_tasks = !self.tasks || (! self.tasks.map {|tsk| tsk.is_finished?(team)}.include?(false) )

    # Duration is ended
    is_finished_by_duration = false
    # TODO: implement finishing the task by duration

    (is_finished_by_codes && is_finished_by_tasks) || is_finished_by_duration
  end

  ##
  # List of hints which are bought by defined team
  #
  def hints_of(team)
    TeamHint.includes(:hint).where('team_hints.team_id = ? and hints.task_id = ?', team.id, self.id).order('hints.number').map(&:hint)
  end

  ##
  # Make the ID for interface
  #
  def make_id
    "#{self.class.name.downcase}#{id}"
  end

  def code_count
    self.codes.try(:size) || 0
  end

  def passed_code_count(team)
    TeamCode.where(team_id: team.id, code_id: self.codes.map(&:id)).size
  end
end
