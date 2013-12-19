# encoding: UTF-8
class HomeController < ApplicationController

  def index
    @games = Game.accessible_by(current_ability).actual
  end

end
