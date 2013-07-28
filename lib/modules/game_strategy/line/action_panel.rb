# encoding: UTF-8
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
  module Line
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
      def data_for_tasks(params)
        ['Задания', params[:url], class: 'nav_link']
      end

      def data_for_stats(params)
        ['Статистика', params[:url], class: 'nav_link']
      end

      def data_for_logs(params)
        ['Логи', params[:url], class: 'nav_link']
      end

      def data_for_results(params)
        game = params[:game]
        game.is_active ? nil : ['Результаты', params[:url], class: 'nav_link']
      end

      def data_for_free_codes(params)
        user = params[:user]
        user.team.codes_number_in_zone(nil) > 0 ? ['Свободные коды', params[:url], class: 'action_link'] : nil
      end

      def data_for_action_bonuses(params)
        result = []
        params[:user].team.action_bonuses.each do |bonus|
	        if bonus.can_new_action?
            result << [bonus.name, '#', class: 'action_link action_bonus', 'data-id' => bonus.id]
		      else
            result << ["#{bonus.name} (#{(bonus.rate.minutes - (Time.now - bonus.last_action_time)).round} c)", '#', class: 'action_link_wait']
          end
        end

        result
      end
    end
  end
end