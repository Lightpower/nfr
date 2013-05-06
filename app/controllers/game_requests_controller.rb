# encoding: UTF-8
class GameRequestsController < ApplicationController
  load_and_authorize_resource

  ##
  # Create game request form current user
  #
  def create
    @game_request.team_id = current_user.team_id
    if @game_request.save
      flash[:notice] = "Заявка подана успешно!"
    else
      flash[:error] = "Ошибка подачи заявки!"
    end
    redirect_to root_path
  end

  ##
  # Delete GameRequest
  #
  def destroy
    if @game_request.delete
      flash[:notice] = "Заявка удалена!"
    else
      flash[:error] = "Ошибка удаления заявки!"
    end
    redirect_to root_path
  end

end
