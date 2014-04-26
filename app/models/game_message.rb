# encoding: UTF-8
class GameMessage < ActiveRecord::Base

  belongs_to :games
  belongs_to :team

  attr_accessible :id, :game_id, :game, :team_id, :team, :from_admin, :message_type, :data

  class << self
    def team_game_messages(team_id, game_id)
      where('game_id=? and(team_id=? or team_id is null)', game_id, team_id).order('created_at DESC')
    end
  end
end
