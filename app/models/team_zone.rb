class TeamZone < ActiveRecord::Base

  belongs_to :team
  belongs_to :zone
  belongs_to :game

  # TODO: change attr_accessible for new rains
  # attr_accessible :game, :game_id, :team, :team_id, :zone, :zone_id

end
