class TeamCode < ActiveRecord::Base

  belongs_to :code
  belongs_to :team
  belongs_to :zone
  belongs_to :team_bonus
  belongs_to :game

  attr_accessible :game, :game_id, :code, :code_id, :data, :team, :team_id, :state, :zone, :zone_id, :bonus, :team_bonus, :team_bonus_id

  class << self

    ##
    # Number of codes which defined team have founded in defined zone before defined time.
    # It counts code bonuses and hint (and other) penalties.
    #
    # Params:
    # - team_id {Integer} - ID of team
    # - zone_id {Integer} - ID of zone. If it is nil then count unzoned codes. If it is :all then count all codes
    #
    def codes_number_of_team(team_id, zone_id=:all, time=Time.now)
      if zone_id != :all
        sum = where(team_id: team_id, zone_id: zone_id).where('created_at <= ?', time).inject(0) {|sum1, item| sum1 + item.bonus }
        sum + TeamHint.where(team_id: team_id, zone_id: zone_id).where('created_at <= ?', time).inject(0) {|sum2, item| sum2 + item.cost }
      else
        sum = where(team_id: team_id).where('created_at <= ?', time).inject(0) {|sum1, item| sum1 + item.bonus }
        sum + TeamHint.where(team_id: team_id).where('created_at <= ?', time).inject(0) {|sum2, item| sum2 + item.cost }
      end
    end

  end
end
