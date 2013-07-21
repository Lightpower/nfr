# encoding: UTF-8
class LogsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource :game

  def index
    if current_user.is_admin?
      @logs = @game.logs.where(result_code: [0, 1, 6, 9]).includes(:code).order('created_at DESC').all
    else
      @logs = @game.logs.where(team_id: current_user.team.id).includes(:code).order('created_at DESC')
    end

    render *GameStrategy::Context.logs_block({game_type: @game.game_type})
  end

  def results
    @stat_result = Stat.total({ game: @game })
    
    render *GameStrategy::Context.logs_result({game_type: @game.game_type})
  end
end
