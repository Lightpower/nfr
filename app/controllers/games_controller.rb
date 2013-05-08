# encoding: UTF-8
class GamesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  ##
  # Get the list of all games (announce)
  #
  def index
    redirect_to root_path
  end

  ##
  # Play the Game
  #
  def show
    @zones = current_user.team.zones

    render 'zones/index', layout: 'layouts/game'
  end

  ##
  # Get statistics
  #
  def stat
    render 'stat/index', locals: {data: Stat.subtotal({ game: @game, team: current_user.team })}, layout: 'layouts/game'
  end

  ##
  # Archive the game
  #
  def archive
    flash_type = :message
    if @game
      if ArchiveFacade.archive(@game)
        message = 'Игра успешно заархивирована'
      else
        message = 'Ошибка архивирования игры!'
        flash_type = :error
      end
    else
      message = 'Игра не найдена'
      flash_type = :error
    end
    render games_path, flash_type => message
  end

end
