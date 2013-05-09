# encoding: UTF-8
class ArchivesController < ApplicationController

  # Show all archives to all users without authorization

  ##
  # List of Games in archive
  #
  def index
    #@games = Game.where(is_archived: true).order('created_at DESC')
    @games = Game.order('start_date DESC')
  end

  ##
  #
  #
  def show
    @game = Game.where(id: params[:id], is_archived: true).first

  end

end
