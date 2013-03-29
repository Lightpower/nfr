class TeamCode < ActiveRecord::Base

  belongs_to :code
  belongs_to :team
  belongs_to :zone

  attr_accessible :code, :code_id, :data, :team, :team_id, :state, :zone, :zone_id, :bonus

  class << self

    ##
    # Number of codes which defined team have founded in defined zone
    # It counts code bonuses and hint (and other) penalties
    #
    def codes_of_team(team_id, zone_id)
      sum = where(team_id: team_id, zone_id: zone_id).inject(0) {|sum1, item| sum1 + item.bonus }
      sum + TeamHint.where(team_id: team_id, zone_id: zone_id).inject(0) {|sum2, item| sum2 + item.cost }
    end

    ##
    # Time of sending last correct code
    #
    def last_code_of_team(team_id, zone_id)
      where(team_id: team_id, zone_id: zone_id, state: Code::STATE_NAMES.index(:accepted)).order("team_codes.created_at").try(:last).try('created_at')
    end
  end

end
