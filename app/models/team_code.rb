class TeamCode < ActiveRecord::Base

  belongs_to :code
  belongs_to :team
  belongs_to :zone

  attr_accessible :code, :code_id, :data, :team, :team_id, :state, :zone, :zone_id

  class << self

    ##
    # Number of codes which defined team have founded in defined zone
    #
    def codes_of_team(team_id, zone_id)
      where(team_id: team_id, zone_id: zone_id, state: 'accepted').size
    end

    ##
    # Time of sending last correct code
    #
    def last_code_of_team(team_id, zone_id)
      where(team_id: team_id, zone_id: zone_id, state: 'accepted').order("team_zones.created_at").try(:first).try(:created_at)
    end
  end

end
