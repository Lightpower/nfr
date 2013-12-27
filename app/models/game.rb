# encoding: UTF-8
class Game < ActiveRecord::Base

  belongs_to :format

  has_many :codes
  has_many :code_strings
  has_many :requests, class_name: 'GameRequest'
  has_many :hints
  has_many :logs
  has_many :tasks
  has_many :team_bonuses
  has_many :team_bonus_actions
  has_many :team_codes
  has_many :team_hints
  has_many :team_zones
  has_many :zones

  has_many :archive_codes
  has_many :archive_code_strings
  has_many :archive_hints
  has_many :archive_logs
  has_many :archive_tasks
  has_many :archive_team_bonuses
  has_many :archive_team_codes
  has_many :archive_team_hints
  has_many :archive_team_zones
  has_many :archive_zones
  has_many :archive_teams

  has_one  :config, class_name: 'GameConfig'

  attr_accessible :number, :name, :format, :format_id, :game_type, :start_date, :finish_date, :price, :area, :image_html,
                  :preview, :legend, :brief_place, :dopy_list, :is_active, :is_archived, :prepare_url, :discuss_url,
                  :is_visible, :auto_teams_accept

  CSS_CLASSES = ['neformat nedostroy', 'neformat game', 'dozor klad', 'dozor classic', 'dozor lite', 'en tochki', 'en cx']

  class << self

    ##
    # Games which are not in archive
    #
    def actual
      where(is_archived: false).order('start_date')
    end

  end

  ##
  # List of teams with accepted requests
  #
  def teams
    requests.where(is_accepted: true).map(&:team).flatten
  end

  ##
  # List of teams with unaccepted requests
  #
  def teams_unaccepted
    requests.where(is_accepted: false).map(&:team).flatten
  end

  ##
  # Get cass class by game format
  #
  def css_class
    result = [self.project.try(:css_class), self.try(:format).try(:css_class)].join(' ')
    result = 'other' unless CSS_CLASSES.include?(result)
    result += ' invisible' unless self.is_visible
    result
  end

  ##
  # Make the ID for interface
  #
  def make_id
    "#{self.class.name.downcase}#{id}"
  end

  ##
  # For game_type='zones':
  # Time which team should hold a zone to get the bonus
  #
  def hold_time
    game_type == 'zones' ? config.time || 99999999 : nil
  end

  ##
  # For game_type='zones':
  # Bonus which team will get if it hold a zone during defined time
  #
  def hold_bonus
    game_type == 'zones' ? config.bonus || 0 : nil
  end

  ##
  # Project of game by Format
  #
  def project
    self.format.try(:project)
  end

  ##
  # Does current game has "is_active = true" and its start_date is being started
  #
  def is_going?
    self.is_active && (self.start_date < Time.now) && (!self.finish_date || self.finish_date > Time.now)
  end

  ##
  # Define if user can create game request
  #
  def can_request?(user)
    self.is_active &&
      user.is_captain? &&
      ! self.teams.include?(user.team) &&
      (!self.finish_date || self.finish_date > Time.now)
  end

  ##
  # Define if user can create game request
  #
  def can_delete_request?(user)
    self.is_active &&
      user.is_captain? &&
      self.teams.include?(user.team) &&
      (self.start_date < Time.now) && (!self.finish_date || self.finish_date > Time.now)
  end

  ##
  # Define if user can create game request
  #
  def can_enter?(user)
    self.is_active &&
      self.teams.include?(user.team) &&
      (self.start_date < Time.now) && (!self.finish_date || self.finish_date > Time.now)
  end
end
