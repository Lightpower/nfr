module Abilities
  module UserAbilities
    include CanCan::Ability

    def abilities_for_user(user)
      return unless user.id

    end

    private

    def abilities_for_user_with_team(user)
      return unless user.team_id

    end

    def abilities_for_user_without_team(user)
      return if user.team_id

    end
  end
end