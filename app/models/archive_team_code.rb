class ArchiveTeamCode < ActiveRecord::Base

  belongs_to :archive_code, class_name: 'ArchiveCode', foreign_key: 'code_id'
  belongs_to :archive_team, class_name: 'ArchiveTeam', foreign_key: 'team_id'
  belongs_to :archive_zone, class_name: 'ArchiveZone', foreign_key: 'zone_id'
  belongs_to :archive_team_bonus, class_name: 'ArchiveTeamBonus', foreign_key: 'team_bonus_id'
  belongs_to :game

  attr_accessible :game, :game_id, :archive_code, :code_id, :data, :archive_team, :team_id, :state,
                  :archive_zone, :zone_id, :bonus, :archive_team_bonus, :team_bonus_id

  class << self

    ##
    # Number of codes which defined team have founded in defined zone before defined time.
    # It counts code bonuses and hint (and other) penalties.
    #
    def codes_number_of_team(team_id, zone_id, time=Time.now)
      if zone_id
        sum = where(team_id: team_id, zone_id: zone_id).where('created_at <= ?', time).inject(0) {|sum1, item| sum1 + item.bonus }
        sum + ArchiveTeamHint.where(team_id: team_id, zone_id: zone_id).where('created_at <= ?', time).inject(0) {|sum2, item| sum2 + item.cost }
      else
        sum = where(team_id: team_id).where('created_at <= ?', time).inject(0) {|sum1, item| sum1 + item.bonus }
        sum + ArchiveTeamHint.where(team_id: team_id).where('created_at <= ?', time).inject(0) {|sum2, item| sum2 + item.cost }
      end
    end
  end
end
