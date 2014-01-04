module Abilities
  module CaptainAbilities
    include CanCan::Ability

    def abilities_for_captain(user)
      return unless user.is_captain?

    end
  end
end