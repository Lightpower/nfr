# encoding: UTF-8
class CodesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :validate_team_presence

  ##
  # Show all free codes with possibility of attaching them to some zone
  #
  def index
    @free_codes = current_user.team.team_codes.where('team_codes.zone_id is null')
    @team_zones = current_user.team.team_zones.map(&:zone)
    render 'codes/index', layout: 'layouts/game'
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

  private

  def validate_team_presence
    raise(CanCan::AccessDenied, 'В доступе отказано: пользователь не привязан ни к одному Дому.') if current_user.team.blank?
  end


end
