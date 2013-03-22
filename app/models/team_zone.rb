class TeamZone < ActiveRecord::Base

  belongs_to :team
  belongs_to :zone

  attr_accessible :team, :team_id, :zone, :zone_id

end
