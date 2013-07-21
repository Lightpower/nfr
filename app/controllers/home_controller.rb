# encoding: UTF-8
class HomeController < ApplicationController

  def index
    @games = Game.actual
    if params[:games]
      # game format
      case params[:games][:project]
        when "other"
          @games = @games.where(format_id: Format.where(project_id: nil).map(&:id))
        when nil
        else
          project = Project.find_by_name(params[:games][:project])
          @games = @games.where(format_id: project.formats.map(&:id))
      end
    end
  end

end
