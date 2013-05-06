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
    render 'stat/index', locals: {data: Stat.total(current_user.team)}, layout: 'layouts/game'
  end

end
