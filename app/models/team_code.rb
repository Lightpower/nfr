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
    def codes_of_team(team_id, zone_id, time=Time.now)
      sum = where(team_id: team_id, zone_id: zone_id).where("created_at <= ?", time).inject(0) {|sum1, item| sum1 + item.bonus }
      sum + TeamHint.where(team_id: team_id, zone_id: zone_id).where("created_at <= ?", time).inject(0) {|sum2, item| sum2 + item.cost }
    end

    ##
    # Time of sending last correct code or hint before defined time.
    # It is searching by :accepted, :accessed states of codes and by all hints
    #
    #
    # Returns
    # - {Hash} - Hash which contains time and state (:accepted, :accessed, :hint)
    #
    def last_code_of_team(team_id, zone_id, time=Time.now)
      code_time = self.where(team_id: team_id, zone_id: zone_id, state: Code::STATE_NAMES.index(:accepted)).order("team_codes.created_at desc").try(:first).try('created_at')
      hint_time = self.where(team_id: team_id, zone_id: zone_id, state: Code::STATE_NAMES.index(:accepted)).order("team_codes.created_at desc").try(:first).try('created_at')
    end
  end

end
