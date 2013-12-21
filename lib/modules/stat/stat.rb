# encoding: UTF-8
module Sbase

  ##
  # Show the intermediate statistics based on Game's game_type
  # Please see methods "subtotal_*" for more detailed description
  #
  # Params:
  # - params {Hash} - Hash with Game and other possible parameters
  #
  def subtotal(params)
    game = params[:game]
    return {error: 'Игра не найдена'} unless game

    begin
      subtotal_class = "stat_#{game.game_type}".classify.constantize
      subtotal_class.subtotal(params)
    rescue
      { error: "Для игры с типом game_type=\"#{game.game_type}\" отчёт subtotal не предусмотрен!"}
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
    return {error: 'Игра не найдена'} unless game

    begin
      total_class = "stat_#{game.game_type}".classify.constantize
      total_class.total(params)
    rescue
      { error: "Для игры с типом game_type=\"#{game.game_type}\" отчёт total не предустмотрен!"}
    end
  end

  ##
  # Wide statistics by all tasks and codes
  #
  def wide(params)
    game = params[:game]
    return {error: 'Игра не найдена'}   unless game
    return {error: 'Игра не в архиве!'} unless game.is_archived

    begin
      wide_class = "stat_#{game.game_type}".classify.constantize
      wide_class.wide(params)
    rescue
      { error: "Для игры с типом game_type=\"#{game.game_type}\" отчёт 'расширенный' не предусмотрен!"}
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
end
