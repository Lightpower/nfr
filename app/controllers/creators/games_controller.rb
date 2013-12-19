##
# Controller for handling Games by their creators and co-creators
#
class Creators::GamesController < ApplicationController

  load_and_authorize_resource :game, except: [:index]

  ##
  # Show the list of my games and shared with me ones.
  #
  def index
    @games = Game.accessible_by(current_ability, :manage).actual
  end

  ##
  # Show game data
  #
  def show

  end

  ##
  # Edit Game's common data
  #
  def edit
    load_formats
  end

  ##
  # Update Game's common data
  #
  def update
    if @game.update_attributes(params[:game])
      redirect_to creators_games_path, notice: 'Игра успешно изменена.'
    else
      render action: 'edit'
    end
  end

  ##
  # New game
  #
  def new
    load_formats
  end

  ##
  # Create my game
  #
  def create
    if @game.save
      redirect_to @game, notice: 'Игра успешно создана'
    else
      render action: 'new'
    end
  end


  private

  def load_formats
    @formats = Format.all.map { |f| [f.project.try(:name) + ' ' + f.name, f.id] }
  end

end
