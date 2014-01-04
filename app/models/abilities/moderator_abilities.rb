module Abilities
  module ModeratorAbilities
    include CanCan::Ability

    def abilities_for_moderator(user)
      return unless user.is_moderator?

      can :manage, Game
    end
  end
end