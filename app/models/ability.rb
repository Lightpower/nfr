class Ability

  include Abilities::AdminAbilities
  include Abilities::CaptainAbilities
  include Abilities::GuestAbilities
  include Abilities::ModeratorAbilities
  include Abilities::UserAbilities

  def initialize(user)
    user ||= User.new

    cannot :all, [:admin_common, :admin_sql]
    #cannot [:create, :update, :delete], Game

    # Abilities are ordered by importance
    abilities_for_guest(user)
    abilities_for_user(user)
    abilities_for_captain(user)
    abilities_for_moderator(user)
    abilities_for_admin(user)

    # Guest or User without team
    #if user.team.blank?
    #  cannot :play, Game
    #end

    # Registered user
    #if user.id
    #  can :manage, User,     id: user.id
    #  can :read,   User
    #  can :create, Team      if user.team.blank?
    #  can :read,   Team
    #  can :manage, TeamRequest, user_id: user.id, by_user: true
    #end

    # Captain
    #if user.is_captain?
    #  can    :manage, Team,        captain: user
    #  cannot :create, Team
    #
    #  cannot :exclude, User,       id: user.id
    #  can :exclude,   User do |u|
    #    (u != user) && (u.team_id == user.team_id)
    #  end
    #
    #  cannot :delete, User
    #
    #  can :manage,    TeamRequest, team_id: user.team_id
    #  can :manage,    GameRequest, team_id: user.team_id
    #end

    ## Access to Game
    #can :read, Game, is_visible: true

    #if user.team.present?
    #
    #  team = user.team
    #
    #  can [:play, :stat, :log], Game do |game|
    #    game.teams.include?(team)
    #  end
    #end
  end
end
