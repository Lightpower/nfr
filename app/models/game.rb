# encoding: UTF-8
class Game < ActiveRecord::Base

  belongs_to :format
  belongs_to :domain

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
  has_one :game_prequel
  alias :prequel :game_prequel

  attr_accessible :number, :name, :format, :format_id, :game_type, :start_date, :finish_date, :price, :area, :image_html,
                  :preview, :legend, :brief_place, :dopy_list, :is_active, :is_archived, :prepare_url, :discuss_url,
                  :is_visible, :auto_teams_accept, :domain, :domain_id

  CSS_CLASSES = ['neformat nedostroy', 'neformat game', 'dozor klad', 'dozor classic', 'dozor lite', 'en tochki', 'en cx', 'fastiv lite']

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

  def is_finished?
    self.finish_date && self.finish_date < Time.now
  end

  ##
  # Define if user can create game request
  #
  def can_request?(user)
    self.is_active &&
      self.is_visible &&
      user.is_captain? &&
      ! self.teams.include?(user.team) &&
      ! self.is_finished?
  end

  ##
  # Define if user can delete game request
  #
  def can_delete_request?(user)
    self.is_active &&
      self.is_visible &&
      user.is_captain? &&
      self.teams.include?(user.team) &&
      (self.start_date > Time.now)
  end

  ##
  # Define if user can create game request
  #
  def can_enter?(user)
    self.is_active &&
      self.teams.include?(user.team) &&
      (self.start_date < Time.now) && (!self.finish_date || self.finish_date > Time.now)
  end

  ##
  # Check if game has active prequel (even unstarted)
  #
  def has_prequel?
    prequel && prequel.is_active && (self.start_date > Time.now)
  end

  ##
  # Define if game's prequel can be shown for defined team
  #
  def can_show_prequel_for?(team)
    self.has_prequel? && self.teams.include?(team)
  end

  ##
  # Logger to save all actions in game
  #
  def logger
    dir = File.dirname("#{Rails.root}/log/#{self.id}/game.log")
    FileUtils.mkdir_p(dir) unless File.directory?(dir)
    @logger ||= Logger.new("#{Rails.root}/log/#{self.id}/game.log")
  end

  def log(params, user)
    user_id = user.id
    user_name = user.show_name
    team = user.team
    team_id = team.id
    team_name = team.name
    if params[:code_string]
      action = 'Код'
      data = params[:code_string][:code]
    elsif params[:task_id]
      action = 'Подсказка'
      data = params[:task_id]
    elsif
      action = 'Ошибка действия'
      data = "params: #{params.to_json}"
    end

    logger.info("#{Time.now.strftime('%F %T')} #{team_id} #{team_name} #{user_id} #{user_name} - #{action}: `#{data}`")
  end
end
