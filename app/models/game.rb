# encoding: UTF-8
class Game < ActiveRecord::Base

  has_many :codes
  has_many :code_strings
  has_many :requests, class_name: "GameRequest"
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

  has_one  :config, class_name: "GameConfig"

  attr_accessible :number, :name, :format, :start_date, :finish_date, :price, :area, :image_html, :preview,
                  :legend, :brief_place, :dopy_list, :is_active, :is_archived,  :prepare_url, :discuss_url

  CSS_CLASSES = %w(nedostroy neformat klads dozor_classic dozor_lite en_tochki en_cx)

  class << self

    ##
    # Games which are not in archive
    #
    def actual
      where(is_archived: false).order("start_date DESC")
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
    result = (self.format || '').downcase.gsub(' ', '_')
    CSS_CLASSES.include?(result) ? result: 'other'
  end

  ##
  # Make the ID for interface
  #
  def make_id
    "#{self.class.name.downcase}#{id}"
  end

  ##
  # Does current game has "is_active = true" and its start_date is being started
  #
  def is_active?
    self.is_active && (self.start_date <= Time.now)
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
end
