class TeamHint < ActiveRecord::Base
  belongs_to :team
  belongs_to :hint
  belongs_to :game

end
