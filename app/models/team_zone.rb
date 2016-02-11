class TeamZone < ActiveRecord::Base

  belongs_to :team
  belongs_to :zone
  belongs_to :game

end
