# encoding: UTF-8
class MobileController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource :game

  def index
    # Codes processing
    if params[:code_string].present?
      @results = GameStrategy::Context.send_code({game: @game, code_string: params[:code_string][:code], user: current_user})
    elsif params[:task_id].present?
      @results = [GameStrategy::Context.get_hint({game: @game, task_id: params[:task_id], user: current_user})]
    else
      @results = nil
    end

    render *GameStrategy::Context.mobile_block({game_type: @game.game_type, input_url: game_m_path(@game)})
  end

end
