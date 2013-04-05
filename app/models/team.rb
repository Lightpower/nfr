class Team < ActiveRecord::Base

  has_many :users
  has_many :zones, through: :team_zones
  has_many :team_codes
  has_many :logs
  has_many :team_bonuses, class_name: 'TeamBonus'
  has_many :team_hints
  has_many :team_zones
  has_many :team_hints

  attr_accessible :name, :alternative_name, :image_url

  ##
  # Number of accepted codes in defined zone
  #
  def codes_number_in_zone(zone, time=Time.now)
    TeamCode.codes_number_of_team(self.id, zone.try(:id), time)
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
    bonus = nil
    self.team_bonuses.each { |team_bonus| bonus = team_bonus.modify_bonus(code, bonus) }
    bonus
  end

end
