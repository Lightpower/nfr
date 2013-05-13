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
    @archive_zones = @game.archive_zones.order(:number) if @game.present?
  end

  ##
  # Show the short statistics of the game
  #
  def short_stat
    @game = Game.where(id: params[:id], is_archived: true).first
    @stat_result = Stat.total({ game: @game })

    render 'archives/stats/results'
  end

  ##
  # Show the statistics of the game
  #
  def wide_stat
    @game = Game.where(id: params[:id], is_archived: true).first
    @stat_result = Stat.wide({ game: @game })

    render 'archives/stats/wide', layout: 'stat'
  end
end
