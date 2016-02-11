class Log < ActiveRecord::Base

  belongs_to :team
  belongs_to :code
  belongs_to :game

  def can_show_info?
    ! [
        Code::STATES.index(:not_found),
        Code::STATES.index(:not_available),
        Code::STATES.index(:not_enough_costs),
        Code::STATES.index(:hint_not_enough_costs)
      ].include?(self.result_code)
  end

  ##
  # Get TeamCode instance of this Log instance
  #
  def team_code
    TeamCode.where(team_id: team_id, code_id: code_id).try(:first)
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
      hint = Hint.where(id: hint_id, game_id: self.game_id).try(:first)
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
      hint = Hint.where(id: hint_id, game_id: self.game_id).try(:first)
      hint.try(:task).try(:zone)
    else
      nil
    end
  end
end
