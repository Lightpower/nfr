# encoding: UTF-8
class MobileController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource :game

  def index
    # Codes processing
    if params[:code_string].present?
      @results = CodeFacade.input({game: current_game, code_string: params[:code_string][:code], user: current_user})
    elsif params[:task_id].present?
      @results = [CodeFacade.get_hint({task_id: params[:task_id], user: current_user})]
    else
      @results = nil
    end

    render 'mobile/index', locals: {input_url: game_m_path(@game)}, layout: 'layouts/mobile'
  end

end
