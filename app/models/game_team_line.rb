# encoding: UTF-8
class GameTeamLine < ActiveRecord::Base

  belongs_to :game
  belongs_to :team
  belongs_to :task

end