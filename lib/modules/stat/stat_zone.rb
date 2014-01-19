# encoding: UTF-8
module StatZone

  class << self
    ##
    # Show the statistics by each kingdoms.
    #
    # Params:
    # - params {Hash} - hash which contains Game and asking Team
    #   - game {Game} - current Game
    #   - asking_team {Team} - Team which is asking for statistics
    #
    #
    # Returns:
    # - {Array of Hash} - List of data by each kingdoms:
    #   - Name
    #   - Master
    #   - Code number of Master
    #   - How long is captured (in minutes)
    #   - Color of Master
    #   - Link to image of Master
    #   - Code number of asking team
    #
    # Example:
    #
    #   {
    #     1 => {
    #       name: 'Winterfell',
    #       team_codes: 12,
    #       holder: {
    #         name: 'Starks',
    #         codes: 15,
    #         time: '01:23:45',
    #         image: '/images/starks.png',
    #       },
    #     2 => {
    #       name: 'Casterly Rocks',
    #       team_codes: 12,
    #       holder: {
    #         name: 'Lannisters',
    #         codes: 11,
    #         time: '03:03:17',
    #         image: '/images/lannisters.png'
    #       },
    #     }
    #   }
    #
    def subtotal(params)
      game = params[:game]
      asking_team = params[:team]
      return [] unless asking_team.present? && asking_team.is_a?(Team)

      result = {}
      Zone.where(game_id: game.id).each do |zone|
        holder = zone.holder
        if holder
          team = holder.team
          result.merge!({
            zone.id =>{
              name: zone.name,
              class: zone.css_class,
              team_codes: asking_team.codes_number_in_zone(zone.try(:id)).round(3),
              holder: {
                name:  team.name,
                codes: team.codes_number_in_zone(zone.try(:id)).round(3),
                time:  Time.at(Time.now.localtime - holder.time.localtime).gmtime.strftime('%H:%M:%S'),
                image: team.image_url
              }
            }
          })
        else
          result.merge!({
            zone.id =>{
              name: zone.name,
              class: zone.css_class,
              team_codes: 0,
              holder: {
                name:  'Free zone',
                codes: 0,
                time:  '00:00:00',
              }
            }
          })
        end
      end

      result
    end


    ##
    # Total statistics of the Game with game_type='zones'
    # It defines if Game is active or archived and call the special method
    #
    def total(params)
      game = params[:game]
      if game.is_active
        total_active(params)
      elsif game.is_archived
        total_archived(params)
      else
        {error: 'Invalid Game parameters'}
      end
    end

    ##
    # Total statistics of the Game with game_type='zones'
    #
    # Params:
    # - params {Hash} - Hash with Game:
    #  - game {Game} - Game whose results should be created
    #
    def total_active(params)
      game = params[:game]
      log = game.logs.order(:created_at)
      zones = game.zones.map(&:id)
      teams = game.teams.map(&:id)
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
        amount = l.team_code.bonus
        new_zone = l.team_code.zone.try(:id)
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
          if result[old_team].present?
            old_bonus = 0
            old_bonus = ((finish_time - zone_holders[zone][:time]).to_i / game.hold_time) * game.hold_bonus if zone_holders[zone][:time].present?
            result[old_team][zone][:bonus] += old_bonus
          end
        rescue Exception => e
          puts ["#{zone.class.name}.id=#{zone.id}", 'Exception:', e].join(' ')
        end
      end

      # total control time and bonus
      total = {}
      teams.each do |team|
        sum = 0
        bonus = 0
        zones.each do |zone|
          sum += result[team][zone][:sum] || 0
          bonus += result[team][zone][:bonus] || 0
        end
        result[team]["total"] = {sum: sum, bonus: bonus}

        # Total bonuses
        total[team] = result[team]["total"][:bonus] +
            zone_holders.values.select{|i| i[:team] == team}.size * (game.config.try(:total_bonus) || 0)
      end

      # Total places sorting
      total = Hash[total.sort {|a, b| b[1] <=> a[1]}]

      {bonuses: result, holders: zone_holders, total: total}
    end

    ##
    # Total statistics of the Game with game_type='zones'
    #
    # Params:
    # - params {Hash} - Hash with Game:
    #  - game {Game} - Game whose results should be created
    #
    def total_archived(params)
      game = params[:game]
      log = game.archive_logs.order(:created_at)
      zones = game.archive_zones.map(&:id)
      teams = game.archive_teams.map(&:id)
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
        amount = l.bonus
        new_zone = l.zone.try(:id)
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
              zone_holders[new_zone][:sum]  = result[ new_team ][new_zone][:sum]
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
          result[old_team][zone][:bonus] += old_bonus if result[old_team].present?
        rescue Exception => e
          puts ["#{zone.class.name}.id=#{zone.id}", 'Exception:', e].join(' ')
        end
      end

      # total
      total = {}
      teams.each do |team|
        sum = 0
        bonus = 0
        zones.each do |zone|
          sum += result[team][zone][:sum] || 0
          bonus += result[team][zone][:bonus] || 0
        end
        result[team]["total"] = {sum: sum.round(3), bonus: bonus.round(3)}

        # Total bonuses
        total[team] = result[team]["total"][:bonus] +
            zone_holders.values.select{|i| i[:team] == team}.size * (game.config.try(:total_bonus) || 0)
      end

      # Total places sorting
      total = Hash[total.sort {|a, b| b[1] <=> a[1]}]

      {bonuses: result, holders: zone_holders, total: total}
    end

    ##
    # Wide statistics by all tasks and codes
    #
    def wide(params)
      result = {header: [], rows: []}
      game = params[:game]
      # column headers
      # zones
      z_row = [{rowspan: 3}] # zones row
      t_row = [] # tasks row
      c_row = [] # codes row
      game.archive_zones.sort_by{|a| a.number }.each do |zone|
        z_row << { colspan: zone.archive_tasks.map(&:archive_codes).flatten.size, data: zone.name}
        zone.archive_tasks.sort_by{|a| a.number }.each do |task|
          t_row << { colspan: task.archive_codes.size, data: task.name}
          task.archive_codes.sort_by{|a| a.number }.each do |code|
            c_row << { data: code.show_code}
          end
        end
      end
      result[:header] << z_row << t_row << c_row

      # body
      code_list = game.archive_zones.map(&:archive_tasks).flatten.map(&:archive_codes).flatten.sort_by do |code|
        [code.archive_zone.try(:id), code.archive_task.try(:id), code.number]
      end

      game.archive_teams.each do |team|
        row = [{data:team.name, b: true}]
        code_list.each do |code|
          team_code = ArchiveTeamCode.where(team_id: team.id, code_id: code.id).try(:first)
          row << {data: team_code ? team_code.created_at.localtime.strftime('%H:%M:%S') : nil }
        end
        result[:rows] << row
      end
      result
    end
  end
end