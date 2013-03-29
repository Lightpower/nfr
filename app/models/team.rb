class Team < ActiveRecord::Base

  has_many :users
  has_many :zones, through: :team_zones
  has_many :team_codes
  has_many :logs
  has_many :team_bonuses
  has_many :team_hints
  has_many :team_zones
  has_many :team_hints

  attr_accessible :name, :alternative_name, :image_url

  ##
  # Number of accepted codes in defined zone
  #
  def codes_number_in_zone(zone)
    TeamCode.codes_of_team(self.id, zone.id)
  end

  ##
  # List of team's codes int defined zone
  #
  def codes_in_zone(zone)
    TeamCode.where(team_id: self.id, zone_id: zone.id, state: [:accepted, :accessed])
  end

  ##
  # Time of last code of current team in defined zone
  #
  def last_code_in_zone
    TeamCode.last_code_of_team(self.id, zone.id)
  end

end
