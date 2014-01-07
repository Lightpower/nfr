# encoding: UTF-8
class ArchiveTask < ActiveRecord::Base

  belongs_to :archive_zone, class_name: 'ArchiveZone', foreign_key: 'zone_id'
  belongs_to :parent_task, class_name: 'ArchiveTask', foreign_key: 'task_id'
  belongs_to :access_code, class_name: 'ArchiveCode', foreign_key: 'code_id'
  belongs_to :game
  has_many   :archive_tasks, class_name: 'ArchiveTask', foreign_key: 'task_id'
  has_many   :archive_hints, class_name: 'ArchiveHint', foreign_key: 'task_id'
  has_many   :archive_codes, class_name: 'ArchiveCode', foreign_key: 'task_id'

  attr_accessible :game, :game_id, :bonus, :code_quota, :preview, :data, :name, :number, :duration, :archive_task,
                  :task_id, :archive_zone, :zone_id, :access_code, :code_id, :bonus, :task_type, :special


  class << self

    ##
    # Ordering by number
    #
    def by_order
      order('archive_tasks.number')
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
    archive_codes.size + 1
  end

  ##
  # Is the task available for defined team
  #
  def is_available?(archive_team)
    return false if archive_team.blank?
    return true if self.archive_zone.blank?
    if archive_team.archive_zones.include?(self.archive_zone)
      self.access_code.blank? || TeamCode.where(team_id: archive_team.id, code_id: self.access_code.id).present?
    else
      false
    end
  end

  ##
  # List of hints which are bought by defined team
  #
  def hints_of(archive_team)
    ArchiveTeamHint.includes(:archive_hint).where("archive_team_hints.team_id = ? and archive_hints.task_id = ?", archive_team.id, self.id).order("archive_hints.number").map(&:archive_hint)
  end

  ##
  # Make the ID for interface
  #
  def make_id
    "#{self.class.name.downcase}#{id}"
  end
end
