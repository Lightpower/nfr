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
      @team_request.delete
      render json: { result: 'ok', status: 200 }
    else
      render json: self.errors, status: 500
    end
  end

  ##
  # AJAX method for rejecting user's request of joining the team
  #
  def reject
    if @team_request.delete
      render json: { result: 'ok', status: 200 }
    else
      render json: { result: @user.errors, status: 500 }
    end
  end

end
