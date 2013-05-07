# encoding: UTF-8
module ArchiveFacade
  class << self
    ##
    # Archive the Game
    #
    def archive(game)
      # Copying the teams which were playing this game
      team_table = {}
      GameRequest.where(game_id: game.id).map(&:team).each do |team|
        archive_team = ArchiveTeam.create(name: team.name, alternative_name: team.alternative_name,
          image_url: team.image_url, team_id: team.id, game_id: game.id)
        team_table.merge!({team.id => archive_team.id})
      end
      # Copying the tables
      %w(Zone Task Code CodeString Hint TeamBonus TeamCode TeamHint TeamZone Log).each do |table|
        copy_and_clear_table(table, game, team_table)

      end
      game.is_archived = true
      game.is_active = false
      game.save
    end

    private

    ##
    # Copy all data of defined game from Table to ArchiveTable and empty source data
    #
    def copy_and_clear_table(table_name, game, team_table)
      main_class =  table_name.constantize
      archive_class = ("Archive#{table_name}").constantize

      main_class.where(game_id: game.id).each do |row|
        archive_instance = archive_class.new
        main_class.column_names.each do |column|
          if column == 'team_id'
            archive_instance.send( "#{column}=", team_table[row.send(column)] )
          else
            archive_instance.send("#{column}=", row.send(column))
          end
        end
        archive_instance.save
      end
      main_class.where(game_id: game.id).map(&:delete)
    end
  end

end