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
    render *GameStrategy::Context.free_codes({game_type: @game.game_type})
  end

  def pass
    # Codes processing
    if params[:code_string].present?
      @results = GameStrategy::Context.send_code({game: @game, code_string: params[:code_string][:code], user: current_user})
    elsif params[:task_id].present?
      @results = [GameStrategy::Context.get_hint({game: @game, task_id: params[:task_id], user: current_user})]
    else
      @results = nil
    end

    @zones = current_user.team.zones

    render *GameStrategy::Context.main_block({game_type: @game.game_type})
  end

  ##
  # Attach free codes to zone
  #
  def attach
    if params[:attach].present?
      result = GameStrategy::Context.attach_unzoned_codes({game: @game, codes: params[:attach], user: current_user})
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

        get_result = GameStrategy::Context.get_code_by_action_bonus( {game: @game, user: current_user}.merge(params[:bonus_action]) )
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
