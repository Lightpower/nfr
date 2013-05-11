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
              team_codes: asking_team.codes_number_in_zone(zone).round(3),
              holder: {
                name:  team.name,
                codes: team.codes_number_in_zone(zone).round(3),
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
        debugger
        amount = l.team_code.bonus
        new_zone = l.team_code.zones.try(:id)
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
        debugger
        amount = l.team_code.bonus
        new_zone = l.team_code.zones.try(:id)
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