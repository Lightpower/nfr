module Abilities
  module GuestAbilities
    include CanCan::Ability

    def abilities_for_guest(user)
      return if user.id

      can :manage, Game
      # can :read, Game, is_visible: true
      can :read, Project
    end
  end
end