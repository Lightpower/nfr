class TeamBonusAction < ActiveRecord::Base

  belongs_to :team_bonus

  attr_accessible :team_bonus, :team_bonus_id, :is_ok
end
