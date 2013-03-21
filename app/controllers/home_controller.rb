# encoding: UTF-8
class HomeController < ApplicationController
  before_filter :authenticate_user!

  def index

  end

  def input
    raise(CanCan::AccessDenied, 'В доступе отказано: пользователь не привязан ни к одному Дому.') if current_user.team.empty?

    flash[:message] = CodeFacade.input(params[:code_string])

    render :index
  end
end
