class Zone < ActiveRecord::Base

  has_many   :teams, throw: :team_zones
  has_many   :team_codes
  has_many   :tasks
  belongs_to :access_code, foreign_key: "code_id"

  attr_accessible :name, :number, :image_url, :access_code, :code_id

  ##
  # Define the master of this zone and the time of capturing
  #
  def master
    result = {}
    teams.each do |team|
      amount = TeamCode.codes_of_team(team.id, self.id)
      last_time = TeamCode.last_code_of_team(team.id, self.id)
      if result[:team_id].blank? || (amount > result[:amount]) || ((amount == result[:amount]) && (last_time < result[:last_time]))
        result = {team_id: team.id, amount: amount, last_time: last_time}
      end
    end

    result
  end
end
