# encoding: UTF-8
class HomeController < ApplicationController
  before_filter :authenticate_user!
  before_filter :validate_team_presence

  def index
    @zone = TeamZone.where(team: current_user.team)

  end

  def input
    raise(CanCan::AccessDenied, 'В доступе отказано: пользователь не привязан ни к одному Дому.') if current_user.team.empty?

    flash[:message] = CodeFacade.input(params[:code_string])

    render :index
  end

  private

  def validate_team_presence
    raise(CanCan::AccessDenied, 'В доступе отказано: пользователь не привязан ни к одному Дому.') if current_user.team.empty?
  end

end
