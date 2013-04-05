class TeamBonus < ActiveRecord::Base

  belongs_to :team

  attr_accessible :amount, :bonus_type, :rate, :team, :team_id, :ko, :description


  ##
  # Modify bonus of code by TeamBonus if this is Multiplier bonus type
  #
  # Params:
  # - code {Code}   - Code which bonus should be modified
  # - bonus {float} - Bonus which is already modified by other TeamBonuses
  #
  # Returns:
  # - {float} - modified bonus
  #
  def modify_bonus(code, bonus=nil)
    if code.present? && code.is_a?(Code)
      bonus ||= code.bonus
      bonus *= self.rate    if (self.bonus_type == "KoMultiplier") && (code.bonus > 0) && (code.ko == self.ko)
      bonus
    else
      0
    end
  end
end
