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
      # Copying the tables and clear them
      %w(Zone Task Code CodeString Hint TeamBonus TeamCode TeamHint TeamZone Log).each do |table|
        copy_and_clear_table({ table: table, game: game, team_table: team_table })
      end
      # Copy logs - successful records only
      copy_and_clear_table({ table: table, game: game, team_table: team_table,
        result_filter: [Code::STATES.index(:accepted), Code::STATES.index(:accessed), Code::STATES.index(:hint_accessed), Code::STATES.index(:attached)]
                           })
      game.is_archived = true
      game.is_active = false
      game.save
    end

    private

    ##
    # Copy all data of defined game from Table to ArchiveTable and empty source data
    #
    def copy_and_clear_table(params)
      table_name = params[:table]
      game = params[:game]
      team_table = params[:team_table]
      result_filter = params[:result_filter] # for Log only
      main_class =  table_name.constantize
      archive_class = ("Archive#{table_name}").constantize

      main_class.where(game_id: game.id).each do |row|
        archive_instance = archive_class.new
        main_class.column_names.each do |column|
          if result_filter.include?(row.result_code)
            if column == 'team_id'
              archive_instance.send( "#{column}=", team_table[row.send(column)] )
            else
              archive_instance.send("#{column}=", row.send(column))
            end
          end
        end
        archive_instance.save
      end
      main_class.where(game_id: game.id).map(&:delete)
    end
  end

end