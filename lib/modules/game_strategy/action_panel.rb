module GameStrategy

  ##
  # Process the data for Action panel due to GameStrategy
  #
  # - Check if action able
  # - Form the data for hyperlinks:
  #   - caption
  #   - reference
  #   - css class
  #   - data-parameters for links
  #
  # Returns
  # - nil {NilClass} - nil if action isn`t able
  # - {Hash} - hash with caption, reference, css-class and data-params (if needs) to make the link
  #
  module ActionPanel

    ##
    # All methods call the same method of correct strategy due to game_type
    #
    # Params:
    # - params {Hash} - should contain :game_type. It is excluded before calling target class method
    #
    %w(data_for_refresh data_for_tasks data_for_stats data_for_logs data_for_results data_for_free_codes data_for_action_bonuses).each do |method_name|
      define_method method_name do |params|
        raise ArgumentError.new("#{method_name}: unresolved params: #{params.inspect}") unless verify_data(params)

        "GameStrategy::#{params[:game].game_type.classify}".constantize.send(method_name.to_sym, params)
      end
    end

    private

    def verify_data(params)
      params[:game].is_a?(Game) && params[:user].is_a?(User)
    end
  end
end