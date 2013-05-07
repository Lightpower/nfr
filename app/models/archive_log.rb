class ArchiveLog < ActiveRecord::Base

  belongs_to :archive_team
  belongs_to :archive_code
  belongs_to :game

  attr_accessible :game, :game_id, :data, :archive_team, :team_id, :login, :result_code, :archive_code, :code_id

  def can_show_info?
    ! [Code::STATES.index(:not_found), Code::STATES.index(:not_available)].include?(self.result_code)
  end

  ##
  # Get ArchiveTeamCode instance of this ArchiveLog instance
  #
  def team_code
    ArchiveTeamCode.where(team_id: team_id, code_id: code_id).try(:first)
  end

end
