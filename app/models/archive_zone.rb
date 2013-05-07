# encoding: UTF-8
class ArchiveZone < ActiveRecord::Base

  #has_many   :archive_teams, through: :team_zones
  has_many   :archive_team_zones, class_name: 'ArchiveTeamZone', foreign_key: 'zone_id'
  has_many   :archive_team_codes, class_name: 'ArchiveTeamCode', foreign_key: 'zone_id'
  has_many   :archive_tasks,      class_name: 'ArchiveTask',     foreign_key: 'zone_id'

  belongs_to :access_code,        class_name: 'ArchiveCode',     foreign_key: 'code_id'
  belongs_to :game

  attr_accessible :game, :game_id, :name, :number, :image_url, :access_code, :code_id

  ##
  # Generate autoincrement task number
  #
  def new_task_number
    archive_tasks.size + 1
  end

  ##
  # Make the ID for interface
  #
  def make_id
    "#{self.class.name.downcase}#{id}"
  end

  ##
  # Returns CSS class style for current zone
  #
  def css_class
    Zone::CLASS_NAMES[name]
  end
end
