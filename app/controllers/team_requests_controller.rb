# encoding: UTF-8
class TeamRequestsController < ApplicationController
  load_and_authorize_resource

  ##
  # AJAX method for approving user's request of joining the team
  #
  def accept
    user = @team_request.user
    user.team = @team_request.team
    if user.save
      if @team_request.by_user
        UserMailer.accept_team_request_from_user(user.team, user).deliver
      else
        UserMailer.accept_team_request_from_team(user.team, user).deliver
      end

      TeamRequest.where(user_id: @team_request.user_id).delete_all
      render json: { result: 'ok', status: 200 }
    else
      render json: self.errors, status: 500
    end
  end

  ##
  # AJAX method for rejecting user's request of joining the team
  #
  def reject
    user = @team_request.user
    team = @team_request.team
    by_user = @team_request.by_user
    if @team_request.delete
      if by_user
        UserMailer.reject_team_request_from_user(team, user).deliver
      else
        UserMailer.reject_team_request_from_team(team, user).deliver
      end

      respond_to do |format|
        format.js { render json: { result: 'ok', status: 200 } }
      end
    else
      respond_to do |format|
        format.js { render json: { result: @team_request.errors, status: 500 } }
      end
    end
  end

end
