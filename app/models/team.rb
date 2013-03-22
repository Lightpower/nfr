class Team < ActiveRecord::Base

  has_many :users
  has_many :zones, throw: :team_zones
  has_many :team_codes
  has_many :logs
  has_many :team_bonuses

  attr_accessible :name, :alternative_name, :avatar_url

  ##
  # Get information about each zones: code amount and last code's time
  #
  # Result:
  # - {Hash} Has with code amount and last code time for each zone which is allowed for this team
  #
  def zone_statistics
    result = {}
    zones.each do |zone|
      amount = TimeCode.code_of_team(self.id, zone.id)
      last_time = TimeCode.last_code_of_team(self.id, zone.id)
      result.merge!(zone.id => { amount: amount, last_time: last_time})
    end

    result
  end

end
