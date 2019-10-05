# encoding: UTF-8
class GameConfig < ActiveRecord::Base

  belongs_to :game

  # TODO: change attr_accessible for new rains
  # attr_accessible :time, :bonus, :total_bonus, :game, :game_id
end
