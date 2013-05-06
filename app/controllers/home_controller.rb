# encoding: UTF-8
class HomeController < ApplicationController

  def index
    @games = Game.actual
    if params[:games]
      @games = @games.where("lower(format) = ?", params[:games][:format].downcase) if params[:games][:format]
    end
  end

end
