class TeamBonusAction < ActiveRecord::Base

  belongs_to :team_bonus
  belongs_to :game

  attr_accessible :game, :game_id, :team_bonus, :team_bonus_id, :is_ok
end
