# encoding: utf-8
##
# Controller for handling Games by their creators and co-creators
#
class Creators::GamesController < ApplicationController

  layout 'layouts/creators'
  authorize_resource :game, except: [:index]

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
    @game = Game.find params[:id]
  end

  ##
  # Edit Game's common data
  #
  def edit
    @game = Game.find params[:id]
    load_formats
  end

  ##
  # Update Game's common data
  #
  def update
    @game = Game.find params[:id]
    if @game.update_attributes(game_params)
      redirect_to creators_games_path, notice: 'Игра успешно изменена.'
    else
      render action: 'edit'
    end
  end

  ##
  # New game
  #
  def new
    @game = Game.new
    load_formats
  end

  ##
  # Create my game
  #
  def create
    byebug
    @game = Game.new game_params
    if @game.save
      redirect_to @game, notice: 'Игра успешно создана'
    else
      render action: 'new'
    end
  end


  private

  def load_formats
    @formats = Format.all.map { |f| [ [f.project.try(:name), f.name].join(' - '), f.id] }
  end

  def game_params
    params.require(:game).permit(:number, :format_id, :name, :game_type, :start_at, :finish_at, :price, 
      :area, :image_html, :video_html, :preview, :legend, :brief_place, :dopy_list, 
      :is_visible, :is_active, :is_archived, :auto_teams_accept, :prepare_url, :discuss_url,
      :statistics_url, :scenario_url)
  end
end
