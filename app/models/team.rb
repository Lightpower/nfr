# encoding: UTF-8
class Team < ActiveRecord::Base

  has_many :users
  has_many :zones, through: :team_zones
  has_many :team_codes
  has_many :logs
  has_many :team_bonuses, class_name: 'TeamBonus'
  has_many :team_hints
  has_many :team_zones
  has_many :team_requests
  belongs_to :captain, class_name: 'User', foreign_key: 'user_id'

  validates_presence_of   :name
  validates_uniqueness_of :name

  validates_format_of :name,             with: /\A[\wа-яА-Я\-_\.\!\&]{3,32}\z/
  validates_format_of :alternative_name, with: /\A[\wа-яА-Я\-_\.\!]{3,32}\z/,   if: Proc.new {|t| t.alternative_name.present? }
  validates_format_of :image_url, with: /\Ahttp(s?):\/\/[a-zA-Z0-9\-_\.\/]+\z/,  if: Proc.new {|t| t.image_url.present? }

  before_destroy      {|team| User.where(team_id: team.id).each {|user| user.team_id = nil; user.save }}


  # Scopes
  scope :by_name, order(:name)


  ##
  # Number of all codes in all zones and without zones
  #
  def total_codes_number(time=Time.now)
    TeamCode.codes_number_of_team(self.id, :all, time)
  end

  ##
  # Number of accepted codes in defined zone
  #
  def codes_number_in_zone(zone_id, time=Time.now)
    TeamCode.codes_number_of_team(self.id, zone_id, time)
  end

  ##
  # List of team's codes in defined zone
  #
  def codes_in_zone(zone, time=Time.now)
    team_codes.where(zone_id: zone.id).where('created_at <= ?', time).order("created_at")
  end

  ##
  # Time of sending the last correct code or hint before defined time.
  # It is searching by :accepted, :accessed states of codes and by all hints
  #
  # Returns
  # - {Hash} - Hash which contains time and state (:accepted, :accessed, :hint)
  #
  def last_code_in_zone(zone, time=Time.now)
    codes = {
      code: team_codes.select('created_at, state').where(zone_id: zone.id).where('created_at <= ?', time).order("created_at desc").try(:first),
      hint: team_hints.select('created_at').where(zone_id: zone.id).where('created_at <= ?', time).order("created_at desc").try(:first)
    }

    return nil if codes == {code: nil, hint: nil}

    if codes[:hint].blank? || codes[:code].created_at >= codes[:hint].created_at
      { time: codes[:code].created_at, state: Code::STATES[codes[:code].state] }
    else
      { time: codes[:hint].created_at, state: :hint }
    end

  end

  ##
  # Try to apply all team bonuses to the code
  #
  def modify_bonus(code)
    bonus = code.bonus
    self.modifiable_bonuses.each { |team_bonus| bonus = team_bonus.modify_bonus(bonus, code.ko) }
    bonus || 0
  end

  ##
  # Modifiable bonuses (Multipliers)
  #
  def modifiable_bonuses
    team_bonuses.where(bonus_type: TeamBonus::MODIFIABLE_TYPES)
  end

  ##
  # Action bonuses (Pirates)
  #
  def action_bonuses
    team_bonuses.where(bonus_type: TeamBonus::ACTION_TYPES)
  end

  def game_zones(game)
    self.zones.where("team_zones.team_id = #{self.id} and zones.game_id = #{game.id}")
  end
end
