# encoding: UTF-8
class AddGameRequestsToGame < ActiveRecord::Migration
  def up
    if Rails.env != 'test'
      game = Game.first
      Team.all.each do |team|
        GameRequest.create(game_id: game.id, team_id: team.id, is_accepted: true)
      end
    end
  end

  def down
    GameRequest.delete_all if Rails.env != 'test'
  end
end
