# encoding: UTF-8
module Stat

  class << self
    ##
    # Show the intermediate statistics based on Game's game_type
    # Please see methods "subtotal_*" for more detailed description
    #
    # Params:
    # - params {Hash} - Hash with Game and other possible parameters
    #
    def subtotal(params)
      game = params[:game]
      return {error: 'Game not found'} unless game

      begin
        subtotal_class = "stat_#{game.game_type}".classify.constantize
        subtotal_class.subtotal(params)
      rescue
        { error: "Game with game_type=\"#{game.game_type}\" cannot show subtotal!"}
      end
    end

    ##
    # Show the final statistics based on Game's game_type
    # Please see methods "total_*" for more detailed description
    #
    # Params:
    # - params {Hash} - Hash with Game and other possible parameters
    #
    def total(params)
      game = params[:game]
      return {error: 'Game not found'} unless game

      begin
        total_class = "stat_#{game.game_type}".classify.constantize
        total_class.total(params)
      rescue
        { error: "Game with game_type=\"#{game.game_type}\" cannot show total!"}
      end
    end

    ##
    # Reproduce all codes passing
    #
    def reprocess
      log = TmpLog::DATA.reverse

      zones = %w(1 2 3 4 5 6 7)
      teams = ["styd@ex.ua", "viceversa@ex.ua", "garem@ex.ua", "ktozdes@ex.ua", "sad@ex.ua", "strooks@ex.ua"]
      zone_holders = {}
      zones.each {|z| zone_holders[z] = {team: nil, sum: 0, time: nil} }
      result = {}
      teams.each do |t|
        result[t] = {}
        zones.each { |z| result[t][z] = {sum: 0, bonus: 0} }

      end

      log.each do |l|
        new_team = l[8]
        amount = l[7]
        new_zone = l[4]
        time = Time.parse(l[0])
        time -= 1.day if time > Time.parse('09:00:00')
        next if (new_team[0] == 'a') || (new_zone == "0") || (amount == 0)

        begin
          result[ new_team ][new_zone][:sum] += amount
          # Does the new team have the best sum in zone?
          if result[ new_team ][new_zone][:sum] > zone_holders[new_zone][:sum]
            # Check if this is the new holder
            if zone_holders[new_zone][:team] == new_team
              zone_holders[new_zone][:sum] = result[ new_team ][new_zone][:sum]
            else
              # count bonus
              old_team = zone_holders[new_zone][:team]
              if old_team.present?
                old_bonus = 0
                old_bonus = ((time - zone_holders[new_zone][:time]).to_i / 1800) * 45 if zone_holders[new_zone][:time].present?
                result[old_team][new_zone][:bonus] += old_bonus
              end

              # change holders data
              zone_holders[new_zone][:time] = time
              zone_holders[new_zone][:team] = new_team
              zone_holders[new_zone][:sum] = result[ new_team ][new_zone][:sum]
            end

          end
        rescue Exception => e
          puts [l, e]
        end
      end

      zones.each do |zone|
        time = Time.parse("07:00:00")

        begin
          old_team = zone_holders[zone][:team]
          old_bonus = 0
          old_bonus = ((time - zone_holders[zone][:time]).to_i / 1800) * 45 if zone_holders[zone][:time].present?
          result[old_team][zone][:bonus] += old_bonus
        rescue Exception => e
          puts [zone, e]
        end
      end

      # total
      teams.each do |team|
        sum = 0
        bonus = 0
        zones.each do |zone|
          sum += result[team][zone][:sum] || 0
          bonus += result[team][zone][:bonus] || 0
        end
        result[team]["8"] = {sum: sum, bonus: bonus}
      end

      {bonuses: result, holders: zone_holders}
    end

    ##
    # Total statistics of the Game with game_type='zones'
    #
    # Params:
    # - params {Hash} - Hash with Game:
    #  - game {Game} - Game whose results should be created
    #
    def total_zones(params)
      game = params[:game]
      if game.is_archived?
        log = game.archive_logs.order(:created_at)
        zone_field = 'archive_zone'
        team_field = 'archive_team_zone'
      else
        log_filter = [Code::STATES.index(:accepted), Code::STATES.index(:accessed), Code::STATES.index(:hint_accessed), Code::STATES.index(:attached)]
        log = game.logs.where(result_code: log_filter).order(:created_at)
        zone_field = 'zone_field'
        team_field = 'team_zone'
      end
      zones = game.send(zone_field.pluralize).map(&:id)
      teams = game.send(team_field.pluralize).map(&:id)
      finish_time = game.finish_date

      zone_holders = {}
      zones.each {|z| zone_holders[z] = {team: nil, sum: 0, time: nil} }
      result = {}
      teams.each do |t|
        result[t] = {}
        zones.each { |z| result[t][z] = {sum: 0, bonus: 0} }
      end

      log.each do |l|
        new_team = l.team_id
        debugger
        amount = l.team_code.bonus
        new_zone = l.team_code.send(zone_field).try(:id)
        time = l.created_at
        next if (new_team[0] == 'a') || (new_zone.blank?) || (amount == 0) || (time > finish_time)

        begin
          result[ new_team ][new_zone][:sum] += amount
          # Does the new team have the best sum in zone?
          if result[ new_team ][new_zone][:sum] > zone_holders[new_zone][:sum]
            # Check if this is the new holder
            if zone_holders[new_zone][:team] == new_team
              zone_holders[new_zone][:sum] = result[ new_team ][new_zone][:sum]
            else
              # count bonus
              old_team = zone_holders[new_zone][:team]
              if old_team.present?
                old_bonus = 0
                old_bonus = ((time - zone_holders[new_zone][:time]).to_i / game.hold_time) * game.hold_bonus if zone_holders[new_zone][:time].present?
                result[old_team][new_zone][:bonus] += old_bonus
              end

              # change holders data
              zone_holders[new_zone][:time] = time
              zone_holders[new_zone][:team] = new_team
              zone_holders[new_zone][:sum] = result[ new_team ][new_zone][:sum]
            end

          end
        rescue Exception => e
          puts ["#{l.class.name}.id=#{l.id}", 'Exception:', e].join(' ')
        end
      end

      zones.each do |zone|
        begin
          old_team = zone_holders[zone][:team]
          old_bonus = 0
          old_bonus = ((finish_time - zone_holders[zone][:time]).to_i / game.hold_time) * game.hold_bonus if zone_holders[zone][:time].present?
          result[old_team][zone][:bonus] += old_bonus
        rescue Exception => e
          puts ["#{zone.class.name}.id=#{zone.id}", 'Exception:', e].join(' ')
        end
      end

      # total
      teams.each do |team|
        sum = 0
        bonus = 0
        zones.each do |zone|
          sum += result[team][zone][:sum] || 0
          bonus += result[team][zone][:bonus] || 0
        end
        result[team]["total"] = {sum: sum, bonus: bonus}
      end

      {bonuses: result, holders: zone_holders}
    end

  end
end