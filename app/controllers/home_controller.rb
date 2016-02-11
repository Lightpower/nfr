# encoding: UTF-8
class HomeController < ApplicationController

  # List of projects
  def index
    @projects = Project.accessible_by(current_ability).by_order.all
  end

end
