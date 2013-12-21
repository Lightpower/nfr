# encoding: UTF-8
require 'unicode'

module GameStrategy
  module Conquest
    module Actions

      ##
      # Pass the code/answer to the engine
      #
      # Params:
      # - params {Hash} - hash with code string, user which sent this code, and Game
      #
      # Example:
      #
      #  { game: game, code_string: 'DR12345', user: current_user}
      #
      # Returns:
      # - {Hash} - Result
      #
      def send_code(params)
        res = []
        Unicode::downcase(params[:code_string]).split(" ").uniq.each do |code|
          res << check_code({game: params[:game], code: code, user: params[:user]})
        end
        res << check_code({game: params[:game], code: params[:code_string], user: params[:user]}) if params[:code_string].index(' ').present?
        # Check if this code passing have changed any zone holding
        check_holding(res.select { |i| i[:team_code].present? })

        res.each { |item| item.delete(:team_code) }
        res
      end

      ##
      # Try to buy hint
      #
      # Params:
      # - params {Hash} - hash with task or task_id, user which bought the hint, and Game
      #
      # Example:
      #
      #  { game: game, task: task_instance, user: current_user}
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

        check_hint({hint: hint, user: params[:user]})
      end

      ##
      # Try to pass the code using TeamBonus
      #
      # Params:
      # - params {Hash} - hash with task or task_id, user which bought the hint, and Game
      #
      # Example:
      #
      #  { game: game, task: task_instance, user: current_user}
      #
      # Returns:
      # - {Hash} - hash with results
      #
      # Example:
      #
      # { id: 1092, data: "Hint 1092 (цена -1.0)", result: :hint_not_enough_costs }
      #
      def get_code_by_action_bonus(params)
        user = params[:user]
        team = user.team
        code = params[:code] || Code.find_by_id(params[:code_id])
        bonus = params[:bonus] || team.action_bonuses.find_by_id(params[:bonus_id])
        game = params[:game]
        data = "Бонус #{bonus.try(:name)}"

        # Cannot get hold_code or free code!
        if code.present? && bonus.present? && code.hold_zone.blank? && code.hold_task.blank? && code.zone.present?
          #  Check if team can make this action
          if bonus.can_new_action?

            # mark action as made
            tba = TeamBonusAction.create(game_id: game.id, team_bonus_id: bonus.id, is_ok: false)

            result = nil
            # Check bonus according its type
            if bonus.bonus_type == 'Pirate'
              result = :not_available if TeamCode.where(code_id: code.id).size == 0
            end
            # try to pass this code if it's allowed
            result = check_code_result(game, team, code) if result != :not_available

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
        Log.create(game_id: game.id, login: user.show_name, code_id: code.try(:id), data: data, result_code: Code::STATES.index(result), team: team)

        { id: code.try(:id), data: data, result: result }
      end

      ##
      # Attach free code to some zone
      #
      # Params:
      # - params {Hash} - hash with list of codes and zones, user which attached the codes, and Game
      #
      # Example:
      #
      # - {game: game, codes: {code_1_id => zone_1_id, code_2_id => zone_2_id, ...}, user: current_user}
      #
      # Example:
      #
      # Returns:
      # - {Hash} - hash with results
      #
      # Example:
      #
      # { result: "ok", status: 200 }
      #
      def attach_unzoned_codes(params)
        user = params[:user]
        result = { result: "ok", status: 200 }
        team_codes = []
        params.each_pair do |id, zone_id|
          team_code = TeamCode.find_by_id(id)
          if team_code.present?
            if team_code.zone_id.blank?
              team_code.zone_id = zone_id
              unless team_code.save
                result = { result: "error", status: 500 }
                break
              end
              team_codes << {team_code: team_code}

              # Add to log
              Log.create(game_id: team_code.game_id, login: user.show_name, code_id: team_code.code_id, data: team_code.code.show_code,
                         result_code: Code::STATES.index(:attached), team: user.team)
            end
          else
            result = { result: "not_found", status: 404 }
            break
          end
        end
        check_holding(team_codes)

        result
      end



      #########################
      private #################
      #########################

      ##
      # Seeking the code in database, check it is new, create a record about its getting and write to log anyway
      #
      # Params:
      # - params {Hash} - hash with code string and user who sent this code
      #                http://resist.kiev.ua/intel/
      # Returns
      # - {Symbol} - Code of result (see RESULT)
      #
      def check_code(params)
        user = params[:user]
        game = params[:game]
        code_string = CodeString.where(game_id: game.id, data: params[:code]).first
        code = code_string.try(:code)
        new_team_code = nil

        result = check_code_result(game, user.team, code)

        # Mark as found if need
        case result
          when :accessed_zone
            result = :accessed
            bonus = user.team.modify_bonus(code)
            new_team_code = TeamCode.create(game_id: game.id, team_id: user.team.id, code_id: code.id, state: Code::STATES.index(:accessed), zone_id: code.hold_zone.id, bonus: bonus)
            TeamZone.create(game_id: game.id, team_id: user.team.id, zone_id: code.hold_zone.id)
          when :accessed_task
            result = :accessed
            bonus = user.team.modify_bonus(code)
            new_team_code = TeamCode.create(game_id: game.id, team_id: user.team.id, code_id: code.id, state: Code::STATES.index(:accessed), zone_id: code.zone.try(:id), bonus: bonus)
          when :accepted
            bonus = user.team.modify_bonus(code)
            new_team_code = TeamCode.create(game_id: game.id, team_id: user.team.id, code_id: code.id, state: Code::STATES.index(:accepted), zone_id: code.zone.try(:id), bonus: bonus)
        end

        # Add to log
        Log.create(game_id: game.id, login: user.show_name, code_id: code.try(:id), data: params[:code], result_code: Code::STATES.index(result), team: user.team)

        { id: code.try(:id), data: params[:code], result: result, team_code: new_team_code }
      end


      ##
      # Try to get hint
      #
      def check_hint(params)
        game = params[:hint].game
        hint = params[:hint]
        user = params[:user]
        # Has hint already been taken?
        if user.team.team_hints.flatten.map(&:hint).include? hint
          result = :hint_repeated
        else
          # Does team enough codes to buy this hint?
          if have_enough_codes?(hint, user.team)
            result = :hint_accessed
            TeamHint.create(game_id: game.id, team_id: user.team.id, hint_id: hint.id, zone_id: hint.task.zone.id, cost: hint.cost)
          else
            result = :hint_not_enough_costs
          end
        end

        # Add to log
        Log.create(game_id: game.id, login: user.show_name, data: "Hint #{hint.id} (цена #{hint.cost})", result_code: Code::STATES.index(result), team: user.team)
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
        game = zones.try(:first).try(:game)
        team = Team.find team_id

        # define current holders of each zone
        zones.each do |zone|
          current_holder = ZoneHolder.where(zone_id: zone.id).order(:created_at).last
          if current_holder.blank? || current_holder.team_id != team.id
            amount = team.codes_number_in_zone(zone)
            if current_holder.blank? || current_holder.amount < amount
              team_code = results.select {|res| res[:team_code].zone_id == zone.id}.first[:team_code]
              ZoneHolder.create(game_id: game.id, amount: amount, zone_id: zone.id,
                                team_id: team.id, team_code_id: team_code.id, time: team_code.created_at)
            end
          end
        end
      end

      ##
      # Check if code can be passed by the team and returns result of checking
      #
      def check_code_result(game, team, code)
        # Found?
        if code.is_a?(Code) && code.present?

          # Was this code already found?
          team_code = TeamCode.where(game_id: game.id, team_id: team.id, code_id: code.id)
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
end