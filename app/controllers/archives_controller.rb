# encoding: UTF-8
class ArchivesController < ApplicationController

  # Show all archives to all users without authorization

  ##
  # List of Games in archive
  #
  def index
    @games = Game.where(is_archived: true).order('start_date DESC')
  end

  ##
  # Show all tasks of archive
  #
  def show
    @game = Game.where(id: params[:id], is_archived: true).first

    render *GameStrategy::Context.script_block({game: @game, user: current_user || User.new})
  end

  ##
  # Show the short statistics of the game
  #
  def short_stat
    @game = Game.where(id: params[:id], is_archived: true).first

    render *GameStrategy::Context.total_block({game: @game, user: current_user || User.new})
  end

  ##
  # Show the statistics of the game
  #
  def wide_stat
    @game = Game.where(id: params[:id], is_archived: true).first

    render *GameStrategy::Context.archive_stat_block({game: @game, user: current_user || User.new})
  end
end
