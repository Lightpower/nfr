# encoding: UTF-8
class TeamRequest < ActiveRecord::Base

  belongs_to :user
  belongs_to :team

  # TODO: change attr_accessible for new rains
  # attr_accessible :user, :user_id, :team, :team_id, :by_user

  validates_presence_of :user_id, :team_id, :by_user
  validates_uniqueness_of :user_id, scope: :team_id

  ##
  # Name of TeamRequest for user
  #
  def name_for_user
    self.team.name rescue ''
  end

  ##
  # Name of TeamRequest for team (captain)
  #
  def name_for_team
    self.user.show_name rescue ''
  end
end
