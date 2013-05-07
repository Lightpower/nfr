# encoding: UTF-8
class TeamRequest < ActiveRecord::Base

  belongs_to :user
  belongs_to :team

  attr_accessible :user, :user_id, :team,:team_id, :by_user

  validates_presence_of :user_id, :team_id, :by_user
  validates_uniqueness_of [:team_id, :team_id]

  ##
  # Name of TeamRequest for user
  #
  def name_for_user
    team.name
  end

  ##
  # Name of TeamRequest for team (captain)
  #
  def name_for_team
    user.show_name
  end
end
