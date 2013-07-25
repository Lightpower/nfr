# encoding: UTF-8
module ActionsHelper
  def link_to_refresh
    data = GameStrategy::Context.data_for_refresh({game: @game, user: current_user})
    data ? link_to(*data) : ''
  end

  def link_to_tasks
    data = GameStrategy::Context.data_for_tasks({game: @game, user: current_user, url: game_path(@game)})
    data ? link_to(*data) : ''
  end
  
  def link_to_stats
    data = GameStrategy::Context.data_for_stats({game: @game, user: current_user, url: stat_game_path(@game)})
    data ? link_to(*data) : ''
  end
  
  def link_to_logs
    data = GameStrategy::Context.data_for_logs({game: @game, user: current_user, url: game_logs_path(@game)})
    data ? link_to(*data) : ''
  end
  
  def link_to_results
    data = GameStrategy::Context.data_for_results({game: @game, user: current_user, url: results_game_logs_path(@game)})
    data ? link_to(*data) : ''
  end
  
  def link_to_free_codes
    data = GameStrategy::Context.data_for_free_codes({game: @game, user: current_user, url: game_codes_path(@game)})
    data ? link_to(*data) : ''
  end
  
  def links_to_action_bonuses
    data = GameStrategy::Context.data_for_action_bonuses({game: @game, user: current_user})
    result = ''
    data.each do |link_data|
      result << link_to(*link_data)
    end
    result.html_safe
  end
end
