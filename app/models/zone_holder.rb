class ZoneHolder < ActiveRecord::Base
  belongs_to :zone
  belongs_to :team
  belongs_to :team_code
  belongs_to :game

  attr_accessible :game, :game_id, :amount, :time, :zone, :zone_id, :team, :team_id, :team_code, :team_code_id
end
