# encoding: UTF-8
module ArchiveFacade
  class << self
    ##
    # Archive the Game
    #
    def archive(game)
      game.transaction do
        # Copying the teams which were playing this game
        team_table = {}
        GameRequest.where(game_id: game.id).map(&:team).each do |team|
          archive_team = ArchiveTeam.create(name: team.name, alternative_name: team.alternative_name,
            image_url: team.image_url, team_id: team.id, game_id: game.id)
          team_table.merge!({team.id => archive_team.id})
          GameRequest.where(game_id: game.id).map(&:delete)
        end
        # Copying the tables and clear them
        %w(Zone Task Code CodeString Hint TeamBonus TeamCode TeamHint TeamZone TeamCorrection).each do |table|
          copy_and_clear_table({ table: table, game: game, team_table: team_table })
        end
        # Copy logs - successful records only
        copy_and_clear_table({ table: 'Log', game: game, team_table: team_table,
          result_filter: [Code::STATES.index(:accepted), Code::STATES.index(:accessed), Code::STATES.index(:hint_accessed), Code::STATES.index(:attached)]
                             })
        game.is_archived = true
        game.is_active = false
        game.save
      end

      game
    end

    ##
    # Create new game by copying one from archive
    #
    def copy_from_archive(game)
      return false unless game.is_archived

      new_game = game.dup
      new_game.number *= 10000
      new_game.name += " (копия)"
      new_game.is_active = false
      new_game.is_archived = false
      new_game.save
      # Copy game config
      new_game.config = game.config.dup

      game.transaction do
        new_game.config.save

        # Zones with ALL stuff
        game.archive_zones.each do |archive_zone|
          copy_zone(archive_zone, new_game)
        end
      end

      new_game
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

        condition = result_filter.blank? || result_filter.include?(row.result_code) # check the result_filter
        condition &&= archive_class.find_by_id(row.id).blank?    # check if this record is already archived
        if condition
          archive_instance = archive_class.new
          main_class.column_names.each do |column|
            if column == 'team_id'
              # if this team is not in game requests
              unless team_table[row.team_id]
                team = Team.find(row.team_id)
                archive_team = ArchiveTeam.create(name: team.name, alternative_name: team.alternative_name,
                                                  image_url: team.image_url, team_id: team.id, game_id: game.id)
                team_table.merge!({team.id => archive_team.id})
              end

              archive_instance.send( "#{column}=", team_table[row.team_id] )
            else
              archive_instance.send("#{column}=", row.send(column))
            end
          end
          archive_instance.save
        end
      end
      main_class.where(game_id: game.id).map(&:delete)
    end

    ##
    # Copy Zone with all stuff
    #
    def copy_zone(archive_zone, parent)
      return nil unless archive_zone

      # Create access code if present
      access_code = copy_code(archive_zone.access_code, parent)
      # Create Zone
      zone = Zone.create(
          number: archive_zone.number,
          name: archive_zone.name,
          image_url: archive_zone.image_url,
          preview: archive_zone.preview,
          code_id: access_code.try(:id),
          game_id: parent.id
      )
      # Create tasks
      archive_zone.archive_tasks.each {|item| copy_task(item, zone) }

      zone
    end


    ##
    # Copy Task with all codes, hints and included tasks
    #
    def copy_task(archive_task, parent)
      return nil unless archive_task
      zone_id = parent.is_a?(Zone) ? parent.id : nil
      task_id = parent.is_a?(Task) ? parent.id : nil

      # Create access code if present
      access_code = copy_code(archive_task.access_code, parent.game)
      # Create task
      task = Task.create(
        number: archive_task.number,
        name: archive_task.name,
        preview: archive_task.preview,
        data: archive_task.data,
        code_quota: archive_task.code_quota,
        bonus: archive_task.bonus,
        duration: archive_task.duration,
        zone_id: zone_id,
        task_id: task_id,
        code_id: access_code.try(:id),
        game_id: parent.game_id
      )
      # Copy all Codes
      archive_task.archive_codes.each {|item| copy_code(item, task) }
      # Copy all hints
      archive_task.archive_hints.each {|item| copy_hint(item, task) }
      # Copy all included task
      archive_task.archive_tasks.each {|item| copy_task(item, task) }

      task
    end

    ##
    # Copy Hint
    #
    def copy_hint(archive_hint, parent)
      return nil unless archive_hint
      Hint.create(
          number: archive_hint.number,
          data: archive_hint.data,
          delay: archive_hint.delay,
          cost: archive_hint.cost,
          task_id: parent.id,
          game_id: parent.game_id
      )
    end

    ##
    # Copy Code with CodeStrings
    #
    def copy_code(archive_code, parent)
      return nil unless archive_code
      task_id = parent.is_a?(Task) ? parent.id : nil
      game_id = parent.is_a?(Game) ? parent.id : parent.game_id
      code = Code.create(
          number: archive_code.number,
          name: archive_code.name,
          info: archive_code.info,
          ko: archive_code.ko,
          color: archive_code.color,
          bonus: archive_code.bonus,
          task_id: task_id,
          game_id: game_id
      )
      # Copy all CodeString
      archive_code.archive_code_strings.each {|item| copy_code_string(item, code) }

      code
    end

    ##
    # Copy CodeString from archive
    #
    def copy_code_string(archive_code_string, parent)
      return nil unless archive_code_string
      CodeString.create(
          data: archive_code_string.data,
          color: archive_code_string.color,
          code_id: parent.id,
          game_id: parent.game_id
      )
    end
  end

end