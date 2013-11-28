class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.role == 'admin'
      can :manage, :all
    else

      # Guest or User without team
      if user.team.blank?
        cannot :read, Game
      end

      # Registered user
      if user.id
        can :manage, User,     id: user.id
        can :create, Team      if user.team_id.blank?
        can :read,   Team
        can :manage, TeamRequest, user_id: user.id, by_user: true
      end

      # Captain
      if user.team.try(:captain)
        can    :manage, Team,        captain: user
        cannot :create, Team

        can :manage,    User,        team_id: user.team_id
        can :manage,    TeamRequest, team_id: user.team_id
        can :manage,    GameRequest, team_id: user.team_id
      end

      # Access to Game
      if user.team.present?
        team = user.team
        if team.present?
          can [:show, :stat], Game do |game|
            game.teams.include?(team)
          end
        end
      end
    end

    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
