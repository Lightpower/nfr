##
# Process the data for Action panel
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
module GameStrategy
  module Conquest
    module ActionPanel

      ##
      # Data for Refresh link
      #
      # Params:
      # - params {Hash} - is not used
      #
      # Returns:
      # - caption, reference, class
      #
      def data_for_refresh(params=nil)
        ['Обновить', 'javascript:document.location.reload()', class: 'nav_link refresh']
      end

      ##
      # Data for Refresh link
      #
      # Params:
      # - params {Hash} - hash with Game and current User
      #
      # Returns:
      # - caption, reference, class
      #
      def data_for_tasks

      end

      def data_for_stats

      end

      def data_for_logs

      end

      def data_for_results

      end

      def data_for_free_codes

      end

      def data_for_action_bonuses

      end
    end
  end
end