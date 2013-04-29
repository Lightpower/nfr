# encoding: UTF-8
class GameRequest < ActiveRecord::Base

  belongs_to :game
  belongs_to :team

  attr_accessible :game, :game_id, :team, :team_id, :is_accepted
end
