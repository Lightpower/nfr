##
# Standard actions for Game Strategy
#
module GameStrategy
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
      # - {string} - Result
      #
      def send_code(params)
        raise ArgumentError.new("send_code: Unresolved params: #{params.inspect}") unless verify_send_code_data(params)
        "GameStrategy::#{params[:game].game_type.classify}".constantize.send_code(params) # it raises error if need
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
        raise ArgumentError.new("get_hint: Unresolved params: #{params.inspect}") unless verify_get_hint_data(params)

        "GameStrategy::#{params[:game].game_type.classify}".constantize.get_hint(params) # it raises error if need
      end

      ##
      # Try to pass the code using TeamBonus
      #
      # Params:
      # - params {Hash} - hash with bonus or bonus_id, code or code_id, user which made the action, and Game
      #
      # Example:
      #
      #  { game: game, bonus: bonus_instance, code: code_instance, user: current_user}
      #
      # Returns:
      # - {Hash} - hash with results
      #
      # Example:
      #
      # { id: code.try(:id), data: data, result: result }
      #
      def get_code_by_action_bonus(params)
        raise ArgumentError.new("get_code_by_action_bonus: Unresolved params: #{params.inspect}") unless verify_get_code_by_action_bonus_data(params)

        "GameStrategy::#{params[:game].game_type.classify}".constantize.get_code_by_action_bonus(params) # it raises error if need
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
        raise ArgumentError.new("attach_unzoned_codes: Unresolved params: #{params.inspect}") unless verify_attach_unzoned_codes_data(params)

        "GameStrategy::#{params[:game].game_type.classify}".constantize.attach_unzoned_codes(params) # it raises error if need
      end

    private

      ##
      # Check if params of send_code contain correct data
      #
      def verify_send_code_data(params)
        params[:game].is_a?(Game) && params[:code_string].is_a?(String) && params[:user].is_a?(User)
      end

      ##
      # Check if params of get_hint contain correct data
      #
      def verify_get_hint_data(params)
        params[:game].is_a?(Game) &&
            (params[:task].is_a?(Task) || params[:task_id].is_a?(String)) &&
            params[:user].is_a?(User)
      end

      ##
      # Check if params of get_hint contain correct data
      #
      def verify_get_code_by_action_bonus_data(params)
        params[:game].is_a?(Game) &&
            (params[:bonus].is_a?(TeamBonus) || params[:bonus_id].is_a?(String)) &&
            (params[:code].is_a?(Code) || params[:code_id].is_a?(String)) &&
            params[:user].is_a?(User)
      end

      ##
      # Check if params of get_hint contain correct data
      #
      def verify_attach_unzoned_codes_data(params)
        params[:game].is_a?(Game) && params[:codes].is_a?(Hash) && params[:user].is_a?(User)
      end

    end
end