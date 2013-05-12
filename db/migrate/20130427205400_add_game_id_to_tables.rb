# encoding: UTF-8
class AddGameIdToTables < ActiveRecord::Migration
  def up
    # Create new game
    game = Game.create(number: 1, name: 'Игра престолов', format: 'DozoR Classic',
      start_date: Time.parse('13.04.2013 22:00'), is_active: false, is_archived: false,
      image_html: '<img src="http://classic.dzzzr.ru/kiev/uploaded/kiev/Night/afisha/244.jpg">',
      discuss_url: 'http://www.dzzzr.ru/forum/showthread.php?t=124780'
    )

    raise Exception, 'Game is not created' unless game.valid?

    %w(zones tasks hints codes code_strings team_zones team_codes logs team_bonus team_hints zone_holders team_bonus_actions).each do |table|
      add_column table.to_sym, :game_id, :integer
      execute "update #{table} set game_id=#{game.id}"
      change_column table.to_sym, :game_id, :integer, null: false
      add_index table.to_sym, :game_id
    end
  end

  def down
    %w(zones tasks hints codes code_strings team_zones team_codes logs team_bonus team_hints zone_holders team_bonus_actions).each do |table|
      remove_index  table.to_sym, :game_id
      remove_column table.to_sym, :game_id
    end

    Game.delete_all
  end
end
