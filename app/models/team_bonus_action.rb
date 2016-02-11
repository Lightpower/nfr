class TeamBonusAction < ActiveRecord::Base

  belongs_to :team_bonus
  belongs_to :game

end
