class TeamCode < ActiveRecord::Base

  belongs_to :code
  belongs_to :team
  belongs_to :zone

  attr_accessible :code, :code_id, :data, :team, :team_id, :state, :zone, :zone_id, :bonus

  class << self

    ##
    # Number of codes which defined team have founded in defined zone before defined time.
    # It counts code bonuses and hint (and other) penalties.
    #
    def codes_number_of_team(team_id, zone_id, time=Time.now)
      sum = where(team_id: team_id, zone_id: zone_id).where("created_at <= ?", time).inject(0) {|sum1, item| sum1 + item.bonus }
      sum + TeamHint.where(team_id: team_id, zone_id: zone_id).where("created_at <= ?", time).inject(0) {|sum2, item| sum2 + item.cost }
    end
  end
end
