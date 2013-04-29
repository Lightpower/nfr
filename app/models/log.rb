class Log < ActiveRecord::Base

  belongs_to :team
  belongs_to :code
  belongs_to :game

  attr_accessible :game, :game_id, :data, :team, :team_id, :login, :result_code, :code, :code_id

  def can_show_info?
    ! [Code::STATES.index(:not_found), Code::STATES.index(:not_available)].include?(self.result_code)
  end

  ##
  # Get TeamCode instance of this Log instance
  #
  def team_code
    TeamCode.where(team_id: team_id, code_id: code_id).try(:first)
  end

end
