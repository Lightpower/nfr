class TeamBonusAction < ActiveRecord::Base

  belongs_to :team_bonus
  belongs_to :game

  # TODO: change attr_accessible for new rains
  # attr_accessible :game, :game_id, :team_bonus, :team_bonus_id, :is_ok
end
