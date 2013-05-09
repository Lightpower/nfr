# encoding: UTF-8
class CodesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource :game

  ##
  # Show all free codes with possibility of attaching them to some zone
  #
  def index
    @free_codes = current_user.team.team_codes.where('team_codes.zone_id is null and team_codes.game_id=?', @game.id)
    @team_zones = current_user.team.team_zones.where('team_zones.game_id=?', @game.id).map(&:zone)
    render 'codes/index', layout: 'layouts/game'
  end

  def pass
    # Codes processing
    if params[:code_string].present?
      @results = CodeFacade.input({game: @game, code_string: params[:code_string][:code], user: current_user})
    elsif params[:task_id].present?
      @results = [CodeFacade.get_hint({task_id: params[:task_id], user: current_user})]
    else
      @results = nil
    end

    @zones = current_user.team.zones

    render 'zones/index', layout: 'layouts/game'
  end

  ##
  # Attach free codes to zone
  #
  def attach
    if params[:attach].present?
      result = CodeFacade.attach(params[:attach], current_user)
    else
      result = { result: "error", status: 500 }
    end

    respond_to do |format|
      format.js { render json: result }
    end
  end

  ##
  # Attach free codes to zone
  #
  def bonus_action
    begin
      if params[:bonus_action].present?
        result = { result: "ok", status: 200 }

        get_result = CodeFacade.get_code_by_action_bonus(current_user, params[:bonus_action][:bonus_id], params[:bonus_action][:code_id])
        result = { result: "failed", status: 200 } if get_result[:result] != :accepted
      else
        result = { result: "error", status: 500 }
      end
    rescue
      result = { result: "error", status: 500 }
    end

    respond_to do |format|
      format.js { render json: result }
    end

  end
end
