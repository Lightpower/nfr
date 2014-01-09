module Abilities
  module UserAbilities
    include CanCan::Ability

    def abilities_for_user(user)
      return unless user.id
      for_user_without_team(user)
      for_user_with_team(user)
      for_both_users(user)
    end

    private

    def for_user_with_team(user)
      return if user.team.blank?

      can :read, Game, is_visible: true

      can [:play, :stat, :log], Game do |game|
        game.teams.include?(user.team)
      end

    end

    def for_user_without_team(user)
      return if user.team.present?

      can :create, Team

      can :accept, TeamRequest, user_id: user.id, by_user: false
      can :reject, TeamRequest, user_id: user.id
    end

    def for_both_users(user)
      can :read, Game, is_visible: true

      can :manage, User,     id: user.id
      can :read,   User

      can :read,   Team
    end
  end
end