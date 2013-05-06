# encoding: UTF-8
class HomeController < ApplicationController

  def index
    @games = Game.actual
    if params[:games]
      # game format
      case params[:games][:format]
        when "other"
          @games = @games.where("lower(format) NOT IN (?)", Game::CSS_CLASSES)
        when nil
        else
          @games = @games.where("lower(format) = ?", params[:games][:format].downcase)
      end
    end
  end

end
