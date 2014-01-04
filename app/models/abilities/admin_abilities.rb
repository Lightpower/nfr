module Abilities
  module AdminAbilities
    include CanCan::Ability

    def abilities_for_admin(user)
      return unless user.is_admin?

      can :manage, :all
    end
  end
end