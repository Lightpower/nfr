class TeamHint < ActiveRecord::Base
  belongs_to :team
  belongs_to :hint

  attr_accessible :team, :team_id, :hint, :hint_id, :zone, :zone_id, :cost
end
