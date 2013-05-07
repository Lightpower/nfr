class ArchiveTeamHint < ActiveRecord::Base

  belongs_to :archive_team, class_name: 'ArchiveTeam', foreign_key: 'team_id'
  belongs_to :archive_hint, class_name: 'ArchiveHint', foreign_key: 'hint_id'
  belongs_to :game

  attr_accessible :game, :game_id, :archive_team, :team_id, :archive_hint, :hint_id, :archive_zone, :zone_id, :cost
end
