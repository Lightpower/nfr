# encoding: UTF-8
class LogsController < ApplicationController
  before_filter :authenticate_user!
  load_resource :game
  before_filter :authorize_game!


  def index
    render *GameStrategy::Context.logs_block({game: @game, user: current_user})
  end

  def results
    render *GameStrategy::Context.logs_result({game: @game, user: current_user})
  end

  private

  def authorize_game!
    authorize! :log, @game
  end
end
