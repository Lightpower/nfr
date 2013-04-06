class TeamBonus < ActiveRecord::Base

  belongs_to :team
  has_many   :team_bonus_actions

  attr_accessible :amount, :bonus_type, :rate, :team, :team_id, :ko, :name, :description

  # types
  MODIFIABLE_TYPES = %w(KoMultiplier)
  ACTION_TYPES = %w(Pirate Warrior)

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

  ##
  # Get the time of last action
  #
  def last_action_time
    team_bonus_actions.order('created_at desc').try(:first).try(:created_at)
  end

  ##
  # Can the team get the new action?
  #
  def can_new_action?
    return false unless ACTION_TYPES.include?(bonus_type)

    (self.last_action_time || Time.now - 1.year) < Time.now - self.rate.minutes
  end
end
