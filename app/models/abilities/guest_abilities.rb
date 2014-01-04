module Abilities
  module GuestAbilities
    include CanCan::Ability

    def abilities_for_guest(user)
      return if user.id

      can :read, Game, is_visible: true
    end
  end
end