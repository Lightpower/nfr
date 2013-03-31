# encoding: UTF-8
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
      params[:code_string].downcase.split(" ").each do |code|
        res << check_code({code: code, user: params[:user]})
      end
      res << check_code({code: params[:code_string], user: params[:user]}) if params[:code_string].index(' ').present?

      res #make_result(res)
    end

    ##
    # Try to buy hint
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

      [check_hint(hint, params[:user])]
    end

  private

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
      code_string = CodeString.find_by_data params[:code]
      code = code_string.try(:code)
      # Found?
      if code.present?

        # Was this code already found?
        team_code = TeamCode.where(team_id: user.team.id, code_id: code.id)
        if team_code.blank?

          # check if this is accept code for a new zone
          if code.hold_zone.present?

            result = :accessed
            # Mark as found
            TeamCode.create(team_id: user.team.id, code_id: code.id, state: Code::STATES.index(:accessed), zone_id: code.hold_zone.id, bonus: code.bonus)
            TeamZone.create(team_id: user.team.id, zone_id: code.hold_zone.id)

          else
            # check if this is accept code for a new task
            if code.hold_task.present?

              # Does team have enough codes to pass this code?
              if have_enough_codes?(code, user.team)
                result = :accessed
                # Mark as found
                TeamCode.create(team_id: user.team.id, code_id: code.id, state: Code::STATES.index(:accessed), zone_id: code.zone.id, bonus: code.bonus)
              else
                result = :not_enough_costs
              end

            else
              #Check if Zone of this code is available for this team
              if code.zone.blank? || TeamZone.where(team_id: user.team.id, zone_id: code.zone.id).present?

                # Does team have enough codes to pass this code?
                if have_enough_codes?(code, user.team)
                  result = :accepted
                  # Mark as found
                  TeamCode.create(team_id: user.team.id, code_id: code.id, state: Code::STATES.index(:accepted), zone_id: code.zone.id, bonus: code.bonus)
                else
                  result = :not_enough_costs
                end
              else
                result = :not_available
              end
            end
          end
        else
          result = :repeated
        end
      else
        result = :not_found
      end

      # Add to log
      Log.create(login: user.email, data: params[:code], result_code: Code::STATES.index(result), team: user.team)

      { id: code.try(:id), data: params[:code], result: result }
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
  end

end