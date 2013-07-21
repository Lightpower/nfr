##
# Standard elements rendering for Conquest
#
module GameStrategy
  module Conquest
    module Rendering

      TEMPLATE_PREFIX = 'game_strategies/conquest/'
      LAYOUT = 'game_strategies/conquest/layouts/game'
      LAYOUT_MOBILE = 'game_strategies/conquest/layouts/mobile'

      ##
      # Prepare parameters for main block
      #
      # Params:
      # - params {Hash} - is not used
      #
      # Returns:
      #
      # 'game_strategies/conquest/zones/item', layout: 'game_strategies/conquest/layouts/game'
      #
      def main_block(params=nil)
        return "#{TEMPLATE_PREFIX}zones/index", layout: LAYOUT
      end

      ##
      # Prepare parameters for free codes managing page
      #
      # Params:
      # - params {Hash} - is not used
      #
      # Returns:
      #
      # 'game_strategies/conquest/codes/item', layout: 'game_strategies/conquest/layouts/game'
      #
      def free_codes(params=nil)
        return "#{TEMPLATE_PREFIX}codes/index", layout: LAYOUT
      end

      ##
      # Prepare parameters for statistics block
      #
      # Params:
      # - params {Hash} - {data: {...}} - data which contains statistic info
      #
      # Returns:
      #
      # 'game_strategies/conquest/stat/item', locals: { data: {...} }, layout: 'game_strategies/conquest/layouts/game'
      #
      def stat_block(params)
        return "#{TEMPLATE_PREFIX}stat/index", locals: params, layout: LAYOUT
      end

      ##
      # Prepare parameters for logs block
      #
      # Params:
      # - params {Hash} - is not used
      #
      # Returns:
      #
      # 'game_strategies/conquest/logs/item', layout: 'game_strategies/conquest/layouts/game'
      #
      def logs_block(params=nil)
        return "#{TEMPLATE_PREFIX}logs/index", layout: LAYOUT
      end

      ##
      # Prepare parameters for subtotal results
      #
      # Params:
      # - params {Hash} - is not used
      #
      # Returns:
      #
      # 'game_strategies/conquest/logs/results', layout: 'game_strategies/conquest/layouts/game'
      #
      def logs_result(params=nil)
        return "#{TEMPLATE_PREFIX}logs/results", layout: LAYOUT
      end

      ##
      # Prepare parameters for mobile version of main_block
      #
      # Params:
      # - params {Hash} - {input_url: game_m_path(@game)} - URL for codes passing
      #
      # Returns:
      #
      # 'game_strategies/conquest/mobile/index', locals: {input_url: 'some/url'}, layout: 'game_strategies/conquest/layouts/game'
      #
      def mobile_block(params)
        return "#{TEMPLATE_PREFIX}mobile/index", locals: params, layout: LAYOUT_MOBILE
      end
    end
  end
end