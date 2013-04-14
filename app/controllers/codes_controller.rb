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
  end

  ##
  # Attach free codes to zone
  #
  def attach
    if params[:attach].present?
      result = { result: "ok", status: 200 }

      params[:attach].each_pair do |id, zone_id|
        team_code = TeamCode.find_by_id(id)
        if team_code.present?
          team_code.zone_id = zone_id
          unless team_code.save
            result = { result: "error", status: 500 }
            break
          end
          check_holding([{team_code: team_code}])
        else
          result = { result: "not_found", status: 404 }
          break
        end
      end
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
    #begin
    #  if params[:bonus_action].present?
    #    result = { result: "ok", status: 200 }
    #
    #    get_result = CodeFacade.get_code_by_action_bonus(current_user, params[:bonus_action][:bonus_id], params[:bonus_action][:code_id])
    #    result = { result: "failed", status: 200 } if get_result[:result] != :accepted
    #  else
    #    result = { result: "error", status: 500 }
    #  end
    #rescue
    #  result = { result: "error", status: 500 }
    #end

    result = { result: "error", status: 500 }
    respond_to do |format|
      format.js { render json: result }
    end

  end

  private

  def validate_team_presence
    raise(CanCan::AccessDenied, 'В доступе отказано: пользователь не привязан ни к одному Дому.') if current_user.team.blank?
  end


end
