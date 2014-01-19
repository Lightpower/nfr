# encoding: utf-8
##
# Standard elements rendering for Conquest
#
module GameStrategy
  module Conquest
    module Rendering

      TEMPLATE_PREFIX = 'game_strategies/conquest/'
      LAYOUT = 'game_strategies/conquest/layouts/game'
      LAYOUT_MOBILE = 'game_strategies/conquest/layouts/mobile'
      LAYOUT_SINGLE = 'layouts/stat'

      ##
      # Prepare parameters for main block
      #
      # Params:
      # - params {Hash} - hash of parameter which contains game and current user
      #   - :game {Game} - game which main block should be created for
      #   - :user {Game} - current user
      #
      # Returns:
      #
      # 'game_strategies/conquest/zones/item', layout: 'game_strategies/conquest/layouts/game'
      #
      def main_block(params)
        game = params[:game]
        zones = params[:user].team.zones.where('zones.game_id=?', game.id)
        # Don't show prequel Zone if game is started
        zones = zones.where('zones.id <> ?', game.prequel.zone.try(:id)) if game.is_going? && game.prequel.try(:zone).try(:id)
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
      # - params {Hash} - hash of parameter which contains game and current user
      #   - :game {Game} - game which main block should be created for
      #   - :user {Game} - current user
      #
      # Returns:
      #
      # 'game_strategies/conquest/stat/item', locals: { data: {...} }, layout: 'game_strategies/conquest/layouts/game'
      #
      def stat_block(params)
        user = params[:user]
        if user.is_admin? || user.is_moderator?
          teams, data = full_subtotal({ game: params[:game], team: user.team })
          return "#{TEMPLATE_PREFIX}stat/full_stat", locals: {data: data, teams: teams}, layout: LAYOUT_SINGLE
        else
          data = subtotal({ game: params[:game], team: user.team })
          return "#{TEMPLATE_PREFIX}stat/index", locals: {data: data}, layout: LAYOUT
        end
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

        if user.is_admin? || user.is_moderator?
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
        stat_result = Sbase.total({ game: params[:game] })

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

      ####################
      ###   ARCHIVE    ###
      ####################

      ##
      # Prepare parameters for Game's script block
      #
      # Params:
      # - params {Hash} - hash of parameter which contains game
      #   - :game {Game} - game which script block should be created for
      #
      # Returns:
      #
      # 'game_strategies/conquest/archives/zones/item', layout: default
      #
      def script_block(params)
        @game = params[:game]
        zones = @game.archive_zones
        return "#{TEMPLATE_PREFIX}/archives/zones/index", locals: {zones: zones}
      end

      ##
      # Prepare parameters for Game's result block
      #
      # Params:
      # - params {Hash} - hash of parameter which contains game
      #   - :game {Game} - game which script block should be created for
      #
      # Returns:
      #
      # 'game_strategies/conquest/archives/total', layout: default
      #
      def total_block(params)
        data = total(params)
        return "#{TEMPLATE_PREFIX}/archives/total", locals: {data: data}
      end

      ##
      # Prepare parameters for Game's detailed statistics block
      #
      # Params:
      # - params {Hash} - hash of parameter which contains game
      #   - :game {Game} - game which script block should be created for
      #
      # Returns:
      #
      # 'game_strategies/conquest/archives/stat', layout: default
      #
      def archive_stat_block(params)
        game, teams, data = stat(params)
        return "#{TEMPLATE_PREFIX}/archives/stat", locals: {game: game, teams: teams, data: data}, layout: LAYOUT_SINGLE
      end


      private

      ########################################
      ####  STATISTICS  ######################
      ########################################

      ##
      # Subtotal data
      # It is used during the game
      #
      def subtotal(params)
        game = params[:game]
        team = params[:team]
        data = []
        game.tasks.order(:id).each do |task|
          if task.codes.size > 0
            new_task = { id: task.id, name: task.number.to_s + '. ' + task.name, codes: [] }
            task.codes.by_order.each do |code|
              new_code = {id: code.number}
              team_codes = TeamCode.where(code_id: code.id).all
              new_code[:me] = 1 if team_codes.select{|t| t.team_id == team.id}.size > 0
              new_code[:total] = team_codes.size
              new_task[:codes] << new_code
            end
            data << new_task
          end
        end
        data
      end

      ##
      # Subtotal data
      # It is used during the game
      #
      def full_subtotal(params)
        game = params[:game]
        data = []
        teams = game.teams.map{|team| {id: team.id, name: team.name} }
        game.tasks.order(:id).each do |task|
          if task.codes.size > 0
            new_task = { id: task.id, name: task.number.to_s + '. ' + task.name, codes: [] }
            task.codes.by_order.each do |code|
              new_code = {data: code.show_code, ko: code.ko, passed: []}
              teams.each do |team|
                new_code[:passed] << TeamCode.where(team_id: team[:id], code_id: code.id).try(:first).try(:created_at).try(:localtime)
              end
              new_task[:codes] << new_code
            end
            data << new_task
          end
        end
        [teams.map {|team| team[:name]}, data]
      end

      ##
      # Total data
      # It is used after game's finishing
      #
      def total(params)
        game = params[:game]
        data = []
        game.archive_teams.each do |team|
          data << {team: team.name, result: team.codes_number_in_zone(:all)}
        end
        data.sort{|x, y| y[:result] <=> x[:result]}
      end

      def stat(params)
        game = params[:game]
        teams = game.archive_teams.map{|team| {id: team.id, name: team.name} }
        data = []

        game.archive_tasks.order(:id).each do |task|
          if task.archive_codes.size > 0
            new_task = {id: task.id, name: task.number.to_s + '. ' + task.name, codes: []}
            task.archive_codes.by_order.each do |code|
              new_code = {data: code.show_code, ko: code.ko, passed: []}
              teams.each do |team|
                new_code[:passed] << ArchiveTeamCode.where(team_id: team[:id], code_id: code.id).try(:first).try(:created_at).try(:localtime)
              end
              new_task[:codes] << new_code
            end
            data << new_task
          end
        end

        [game, teams.map {|team| team[:name]}, data]
      end
    end
  end
end