class TeamBonus < ActiveRecord::Base

  belongs_to :team
  belongs_to :game
  has_many   :team_bonus_actions

  # TODO: change attr_accessible for new rains
  # attr_accessible :game, :game_id, :amount, :bonus_type, :rate, :team, :team_id, :ko, :name, :description

  # types
  MODIFIABLE_TYPES = %w(KoMultiplier)
  ACTION_TYPES = %w(Pirate Warrior)

  ##
  # Modify bonus of code by TeamBonus if this is Multiplier bonus type
  #
  # Params:
  # - bonus {float} -  Bonus which is already modified by other TeamBonuses
  # - ko    {string} - KO of code
  #
  # Returns:
  # - {float} - modified bonus
  #
  def modify_bonus(bonus, ko)
    bonus *= self.rate    if (self.bonus_type == "KoMultiplier") && (bonus > 0) && (ko == self.ko)
    bonus
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
