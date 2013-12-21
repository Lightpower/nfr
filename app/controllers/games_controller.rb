# encoding: UTF-8
class GamesController < ApplicationController
  before_filter :authenticate_user!

  load_resource
  before_filter :authorize_game!,     except: [:show, :archive]

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
    if @game.try(:is_active) && @game.teams.include?(current_user.team) && (@game.start_date < Time.now)# check if game is active

      render *GameStrategy::Context.main_block({game: @game, user: current_user})
    elsif @game.blank?
      redirect_to root_path, alert: "Игра с таким номером (#{params[:id]}) не найдена!"
    elsif @game.is_archived
      redirect_to archive_path(@game), notice: "Выбранная игра уже в архиве"
    else
      redirect_to root_path, notice: 'Выбранная игра неактивна'
    end
  end

  ##
  # Get statistics
  #
  def stat
    render *GameStrategy::Context.stat_block( {game: @game, user: current_user} )
  end

  ##
  # Archiving the game
  #
  def archiving
    authorize! :archive, @game

    flash_type = :message
    if @game && !@game.is_archived
      if ArchiveFacade.archive(@game)
        message = 'Игра успешно заархивирована'
      else
        message = 'Ошибка архивирования игры!'
        flash_type = :error
      end
    elsif @game.is_archived
      message = 'Игра уже в архиве'
      flash_type = :notice
    elsif @game.blank?
      message = 'Игра не найдена'
      flash_type = :error
    else
      message = 'Не удалось заархивировать игру!'
      flash_type = :error
    end
    redirect_to (@game? archive_path(@game) : games_path), flash_type => message
  end

  private

  def authorize_game!
    authorize! :play, @game
  end

end
