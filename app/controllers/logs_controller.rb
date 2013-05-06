# encoding: UTF-8
class LogsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource :game

  def index
    if current_user.is_admin?
      @logs = Log.where(result_code: [0, 1, 6, 9]).order('created_at DESC').all
    else
      @logs = current_user.team.logs.order('created_at DESC')
    end

    render 'logs/index', layout: 'layouts/game'
  end

  def results
    @stat_result = Stat.reprocess

    render 'logs/results', layout: 'layouts/game'
  end
end
