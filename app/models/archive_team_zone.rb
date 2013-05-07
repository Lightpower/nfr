class ArchiveTeamZone < ActiveRecord::Base

  belongs_to :archive_team, class_name: 'ArchiveTeam', foreign_key: 'team_id'
  belongs_to :archive_zone, class_name: 'ArchiveZone', foreign_key: 'zone_id'
  belongs_to :game

  attr_accessible :game, :game_id, :archive_team, :team_id, :archive_zone, :zone_id

end
