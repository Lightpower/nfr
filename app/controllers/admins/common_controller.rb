# encoding: UTF-8
class Admins::CommonController < ApplicationController

  before_filter :authenticate_user!
  authorize_resource class: false


  ##
  # Some action
  #
  def action
    #ArchiveFacade.copy_from_archive(Game.first)
    redirect_to root_path, notice: 'Admin action is processed'
  end

  private

  ##
  # Check if current_user is admin
  #
  def admin_check
    current_user.is_admin?
  end

end
