# encoding: UTF-8
class GameConfig < ActiveRecord::Base

  belongs_to :game

  attr_accessible :time, :bonus, :game, :game_id
end
