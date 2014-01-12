module Abilities
  module CaptainAbilities
    include CanCan::Ability

    def abilities_for_captain(user)
      return unless user.is_captain?

      can :read, Game, is_visible: true

      can :manage, Team, captain: user

      can :exclude, User do |u|
        (u != user) && (u.team_id == user.team_id)
      end

      can :accept, TeamRequest, team_id: user.team_id, by_user: true
      can :reject, TeamRequest, team_id: user.team_id

      can :create, GameRequest do |gr|
        game = Game.find(gr.game_id)
        game.can_request?(user)
      end

      can :delete, GameRequest do |gr|
        game = Game.find(gr.game_id)

        gr.team_id == user.team_id && !game.is_finished?
      end
    end
  end
end