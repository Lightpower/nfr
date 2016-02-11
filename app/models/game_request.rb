# encoding: UTF-8
class GameRequest < ActiveRecord::Base

  belongs_to :game
  belongs_to :team

end
