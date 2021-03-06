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

  ##
  # Define bonus of current Log
  #
  def bonus
    # For codes
    if self.code_id
      self.team_code.bonus
    elsif (self.data =~ /^Hint /) == 0
      # for Hints
      hint_id = self.data.split(" ")[1].to_i
      hint = ArchiveHint.where(id: hint_id, game_id: self.game_id).try(:first)
      if hint
        hint.cost
      else
        0
      end
    else
      0
    end
  end

  ##
  # Define zone of code or hint
  #
  def zone
    # For codes
    if self.code_id
      self.team_code.archive_zone
    elsif (self.data =~ /^Hint /) == 0
      # for Hints
      hint_id = self.data.split(" ")[1].to_i
      hint = ArchiveHint.where(id: hint_id, game_id: self.game_id).try(:first)
      hint.try(:archive_task).try(:archive_zone)
    else
      nil
    end
  end
end
