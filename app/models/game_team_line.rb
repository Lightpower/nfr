# encoding: UTF-8
class GameTeamLine < ActiveRecord::Base

  belongs_to :game
  belongs_to :team
  belongs_to :task

  # TODO: change attr_accessible for new rains
  # attr_accessible :num, :game, :game_id, :team, :team_id, :task, :task_id, :start_at, :finish_at, :stopped
end