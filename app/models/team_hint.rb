class TeamHint < ActiveRecord::Base
  belongs_to :team
  belongs_to :hint
  belongs_to :game

  # TODO: change attr_accessible for new rains
  # attr_accessible :game, :game_id, :team, :team_id, :hint, :hint_id, :zone, :zone_id, :cost
end
