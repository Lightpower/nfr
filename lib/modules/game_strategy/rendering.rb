##
# Standard elements rendering for Game Strategy
#
module GameStrategy
  ##
  # Prepare data for rendering
  #
  # Result of each public method is parameters for 'render' method
  #
  module Rendering

    ##
    # All methods call the same method of correct strategy due to game_type
    #
    # Params:
    # - params {Hash} - should contain :game_type. It is excluded before calling target class method
    #
    %w(main_block free_codes stat_block logs_block logs_result mobile_block).each do |method_name|
      define_method method_name do |params|
        raise ArgumentError.new("#{method_name}: params[:game_type] is missing") unless params[:game_type]
        debugger
        "GameStrategy::#{params[:game_type].classify}".constantize.send(method_name.to_sym, params.except(:game_type))
      end
    end
  end
end