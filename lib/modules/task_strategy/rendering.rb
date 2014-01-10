# encoding: utf-8
##
# Standard elements rendering for Task Strategy
#
module TaskStrategy
  ##
  # Prepare data for rendering
  #
  # Result of each public method is HTML string
  #
  module Rendering

    ##
    # All methods call the same method of correct strategy due to task_type
    #
    # Params:
    # - params {Hash} - must contain :task and :user (current_user)
    #
    %w(codes_block).each do |method_name|
      define_method method_name do |params|
        raise ArgumentError.new("#{method_name}: unresolved params - #{params.inspect}") unless verify_data(params)
        # If task_type='' then TaskStrategy::Default
        task_type = params[:task].task_type.present? ? params[:task].task_type : 'default'

        "TaskStrategy::#{task_type.classify}".constantize.send(method_name.to_sym, params)
      end
    end

  private

    def verify_data(params)
      params[:task].is_a?(Task) && params[:user].is_a?(User)
    end
  end
end