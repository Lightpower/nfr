##
# Standard elements rendering for Conquest
#
module GameStrategy
  module Line
    module Rendering

      TEMPLATE_PREFIX = 'game_strategies/line/'
      LAYOUT = 'game_strategies/line/layouts/game'
      LAYOUT_MOBILE = 'game_strategies/line/layouts/mobile'

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
      def main_block(params)
        zones = params[:user].team.zones.where('zones.game_id=?', params[:game].id)
        return "#{TEMPLATE_PREFIX}zones/index", locals: {zones: zones}, layout: LAYOUT
      end

      ##
      # Prepare parameters for free codes managing page
      #
      # Params:
      # - params {Hash} - hash with game and current user
      #
      # Returns:
      #
      # 'game_strategies/conquest/codes/item', layout: 'game_strategies/conquest/layouts/game'
      #
      def free_codes(params)
        game = params[:game]
        user = params[:user]

        free_codes = user.team.team_codes.where('team_codes.zone_id is null and team_codes.game_id=?', game.id)
        team_zones = user.team.team_zones.where('team_zones.game_id=?', game.id).map(&:zone)
        return "#{TEMPLATE_PREFIX}codes/index", locals: {free_codes: free_codes, team_zones: team_zones}, layout: LAYOUT
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
        data = Stat.subtotal({ game: params[:game], team: params[:user].team })
        return "#{TEMPLATE_PREFIX}stat/index", locals: {data: data}, layout: LAYOUT
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
      def logs_block(params)
        game = params[:game]
        user = params[:user]

        if user.is_admin?
          logs = game.logs.where(result_code: [0, 1, 6, 9]).includes(:code).order('created_at DESC').all
        else
          logs = game.logs.where(team_id: user.team.id).includes(:code).order('created_at DESC')
        end

        return "#{TEMPLATE_PREFIX}logs/index", locals: {logs: logs}, layout: LAYOUT
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
      def logs_result(params)
        stat_result = Stat.total({ game: params[:game] })

        return "#{TEMPLATE_PREFIX}logs/results", locals: {stat_result: stat_result}, layout: LAYOUT
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

  ##############################
  private ######################
  ##############################

      ##
      # Check if current task for defined team is actual. If no, set the new current task
      #
      def process_current_task(params)
        game = params[:game]
        team = params[:user].team



      end

    end
  end
end