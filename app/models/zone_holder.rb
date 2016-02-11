class ZoneHolder < ActiveRecord::Base

  belongs_to :zone
  belongs_to :team
  belongs_to :team_code
  belongs_to :game

end
