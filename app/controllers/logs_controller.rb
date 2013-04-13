# encoding: UTF-8
class LogsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :validate_team_presence

  def index
    if current_user.is_admin?
      @logs = Log.order('created_at DESC').all
    else
      @logs = current_user.team.logs.order('created_at DESC')
    end
    render 'logs/index'
  end

  private

  def validate_team_presence
    raise(CanCan::AccessDenied, 'В доступе отказано: пользователь не привязан ни к одному Дому.') if current_user.team.blank?
  end


end
