# encoding: UTF-8
#require 'unicode'
module CodeFacade

  class << self
    ##
    # Get the group of codes and try to pass each of them. Write the log and return total result
    #
    # Params:
    # - params {Hash} - hash with code string and user which sent this code
    #
    # Returns:
    # - {string} - Result
    def input(params)
      res = []
      code_time = params[:time]
      #Unicode::downcase(params[:code_string]).split(" ").uniq.each do |code|
      params[:code_string].downcase.split(" ").uniq.each do |code|
        res << check_code({code: code, user: params[:user], time: code_time})
      end
      res << check_code({code: params[:code_string], user: params[:user], time: code_time}) if params[:code_string].index(' ').present?
      # Check if this code passing have changed any zone holding
      check_holding(res.select { |i| i[:team_code].present? })

      res.each { |item| item.delete(:team_code) }
      res
    end

    ##
    # Try to buy hint
    #
    # Returns:
    # - {Hash} - hash with results
    #
    # Example:
    #
    # { id: 1092, data: "Hint 1092 (цена -1.0)", result: :hint_not_enough_costs }
    #
    def get_hint(params)
      task = params[:task] || Task.find_by_id(params[:task_id])
      return {hint: nil, result: :not_available} if task.blank?

      hint = nil
      task.hints.by_order.each do |item|
        unless item.is_got_by_team?(params[:user].team)
          hint = item
          break
        end
      end
      return {hint: nil, result: :not_available} if hint.blank?

      check_hint(hint, params[:user])
    end

    ##
    # Try to pass the code using TeamBonus
    #
    def get_code_by_action_bonus(user, bonus_id, code_id)
      team = user.team
      code = Code.find_by_id code_id
      bonus = team.action_bonuses.find_by_id(bonus_id)
      data = "Бонус #{bonus.try(:name)}"
      new_team_code = nil

      # Cannot get hold_code or free code!
      if code.present? && bonus.present? && code.hold_zone.blank? && code.hold_task.blank? && code.zone.present?
        #  Check if team can make this action
        if bonus.can_new_action?

          # mark action as made
          tba = TeamBonusAction.create(team_bonus_id: bonus.id, is_ok: false)

          result = nil
          # Check bonus according its type
          if bonus.bonus_type == 'Pirate'
            result = :not_available if TeamCode.where(code_id: code.id).size == 0
          end
          # try to pass this code if it's allowed
          result = check_code_result(team, code) if result != :not_available

          if result == :accepted
            tba.is_ok = true
            tba.save
          end
        else
          result = :not_available
        end
      else
        result = :not_found
      end

      # Mark as found if need
      if result == :accepted
        bonus = user.team.modify_bonus(code)
        new_team_code = TeamCode.create(team_id: team.id, code_id: code.id, state: Code::STATES.index(:accepted),
                                        zone_id: code.zone.try(:id), bonus: bonus, team_bonus_id: bonus_id)
        check_holding([{team_code: new_team_code}])
      end


      # Add to log
      Log.create(login: user.email, code_id: code.try(:id), data: data, result_code: Code::STATES.index(result), team: team)

      { id: code.try(:id), data: data, result: result }
    end



  #########################
  private #################
  #########################

    ##
    # Seeking the code in database, check it is new, create a record about its getting and write to log anyway
    #
    # Params:
    # - params {Hash} - hash with code string and user who sent this code
    #
    # Returns
    # - {Symbol} - Code of result (see RESULT)
    #
    def check_code(params)
      user = params[:user]
      code_time = params[:time]
      code_string = CodeString.find_by_data params[:code]
      code = code_string.try(:code)
      new_team_code = nil

      result = check_code_result(user.team, code)

      # Mark as found if need
      case result
        when :accessed_zone
          result = :accessed
          bonus = user.team.modify_bonus(code)
          new_team_code = TeamCode.create(team_id: user.team.id, code_id: code.id, state: Code::STATES.index(:accessed), zone_id: code.hold_zone.id, bonus: bonus)
          TeamZone.create(team_id: user.team.id, zone_id: code.hold_zone.id)
        when :accessed_task
          result = :accessed
          bonus = user.team.modify_bonus(code)
          new_team_code = TeamCode.create(team_id: user.team.id, code_id: code.id, state: Code::STATES.index(:accessed), zone_id: code.zone.try(:id), bonus: bonus)
        when :accepted
          bonus = user.team.modify_bonus(code)
          new_team_code = TeamCode.create(team_id: user.team.id, code_id: code.id, state: Code::STATES.index(:accepted), zone_id: code.zone.try(:id), bonus: bonus)
      end

      # Add to log
      Log.create(login: user.email, code_id: code.try(:id), data: params[:code], result_code: Code::STATES.index(result), team: user.team)

      { id: code.try(:id), data: params[:code], result: result, team_code: new_team_code }
    end


    ##
    # Try to get hint
    #
    def check_hint(hint, user)
      # Has hint already been taken?
      if user.team.team_hints.flatten.map(&:hint).include? hint
        result = :hint_repeated
      else
        # Does team enough codes to buy this hint?
        if have_enough_codes?(hint, user.team)
          result = :hint_accessed
          TeamHint.create(team_id: user.team.id, hint_id: hint.id, zone_id: hint.task.zone.id, cost: hint.cost)
        else
          result = :hint_not_enough_costs
        end
      end

      # Add to log
      Log.create(login: user.email, data: "Hint #{hint.id} (цена #{hint.cost})", result_code: Code::STATES.index(result), team: user.team)
      {id: hint.id, data: "Hint #{hint.id} (цена #{hint.cost})", result: result}
    end

    ##
    # Check if team has enough codes in this zone to pass this code
    #
    def have_enough_codes?(code_or_hint, team)
      case code_or_hint.class.name
        when 'Code'
          return true if code_or_hint.zone.blank?
          cost = code_or_hint.bonus
          zone = code_or_hint.zone
        when 'Hint'
          cost = code_or_hint.cost
          zone = code_or_hint.task.zone
        else
          return false
      end

      team.codes_number_in_zone(zone) + cost >= 0
    end

    ##
    # Change the holder of zones if should
    #
    # Params:
    # - results      {Array of Hash} - result of #check_code
    #
    # Returns:
    # - {Array of String} - list of names of zones that change their holders
    #
    def check_holding(results)
      # Get the list of zones
      zones = results.map { |res| res[:team_code].try(:zone) }.compact
      return [] if zones.blank?
      team_id = results.first[:team_code].try(:team_id)
      return [] if team_id.blank?
      team = Team.find team_id

      # define current holders of each zone
      zones.each do |zone|
        current_holder = ZoneHolder.where(zone_id: zone.id).order(:created_at).last
        if current_holder.blank? || current_holder.team_id != team.id
          amount = team.codes_number_in_zone(zone)
          if current_holder.blank? || current_holder.amount < amount
            team_code = results.select {|res| res[:team_code].zone_id == zone.id}.first[:team_code]
            ZoneHolder.create(amount: amount, zone_id: zone.id,
                              team_id: team.id, team_code_id: team_code.id, time: team_code.created_at)
          end
        end




        #holders.merge!(zone.id => {amount: 0, time: Time.now - 2.days, team: nil} )
        #Team.all.each do |team|
        #  amount = team.codes_number_in_zone(zone)
        #  time = team.last_code_in_zone(zone)
        #  if time.present?
        #    time = time[:time] if time
        #  else
        #    time = Time.now - 1.day
        #  end
        #
        #
        #  if( amount > holders[zone.id][:amount]) ||
        #      ( (amount == holders[zone.id][:amount]) && (time < holders[zone.id][:time]) )
        #
        #    holders[zone.id] = { amount: amount, time: time, team: team }
        #  end
        #end
        #if zone.holder != holders[zone.id][:team]
        #  team_code = TeamCode.order('created_at DESC').first
        #  ZoneHolder.create(amount: holders[zone.id][:amount], zone_id: zone.id,
        #    team_id: holders[zone.id][:team].id, team_code_id: team_code.id, time: team_code.created_at)
        #end
      end
    end

    ##
    # Check if code can be passed by the team and returns result of checking
    #
    def check_code_result(team, code)
      # Found?
      if code.is_a?(Code) && code.present?

        # Was this code already found?
        team_code = TeamCode.where(team_id: team.id, code_id: code.id)
        if team_code.blank?

          # check if this is accept code for a new zone
          if code.hold_zone.present?
            result = :accessed_zone
            # check if this is accept code for a new task
          elsif code.hold_task.present?

            # Does team have enough codes to pass this code?
            if have_enough_codes?(code, team)
              result = :accessed_task
            else
              result = :not_enough_costs
            end
          else
            #Check if Zone of this code is available for this team
            #if (code.zone.blank? || TeamZone.where(team_id: team.id, zone_id: code.zone.id).present?)
            if code.task.is_available?(team)

              # Does team have enough codes to pass this code?
              if have_enough_codes?(code, team)
                result = :accepted
                # Mark as found
              else
                result = :not_enough_costs
              end
            else
              result = :not_available
            end
          end
        else
          result = :repeated
        end
      else
        result = :not_found
      end
      result
    end

  end
end