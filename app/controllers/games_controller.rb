# encoding: UTF-8
class GamesController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :preview, :archive]

  load_resource
  before_filter :authorize_game!,     except: [:index, :preview, :show, :archive]

  ##
  # Get the list of all games (announce)
  #
  def index
    if params[:project_id]
      @games = Game.of_project(params[:project_id])
    else
      @games = Game.actual
    end
  end

  ##
  # Play the Game
  #
  def show
    # Prequel
    show_prequel ||

    # Real Game
    show_started_game
  end

  def preview
  end

  ##
  # Get statistics of started game
  #
  def stat
    if (@game.start_at > Time.now) && !(current_user.is_admin? || current_user.is_moderator?)
      redirect_to game_path(@game), notice: 'Статистика будет доступна после старта игры.'
    else
      render *GameStrategy::Context.stat_block( {game: @game, user: current_user} )
    end
  end

  ##
  # Archiving the game
  #
  def archive
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

  ##
  # Show prequel
  #
  def show_prequel
    # check if prequel is accessible by current team AND game is not started yet
    if @game.can_show_prequel_for?(current_user.team) && (@game.start_at > Time.now)
      zone = @game.prequel.zone
      TeamZone.create(game_id: @game.id, team_id: current_user.team.id, zone_id: zone.id) if !@game.is_going? && TeamZone.where(team_id: current_user.team.id, zone_id: zone.id).blank?
      render *GameStrategy::Context.main_block({game: @game, user: current_user})
    end
  end


  ##
  # Show game that is started
  #
  def show_started_game
    if @game.is_going? && @game.teams.include?(current_user.team)

      render *GameStrategy::Context.main_block({game: @game, user: current_user})
    elsif @game.blank?
      redirect_to root_path, alert: "Игра с таким номером (#{params[:id]}) не найдена!"
    elsif @game.is_archived
      redirect_to archive_path(@game), notice: 'Выбранная игра уже в архиве'
    else
      redirect_to root_path, notice: 'Выбранная игра неактивна'
    end

  end

end
