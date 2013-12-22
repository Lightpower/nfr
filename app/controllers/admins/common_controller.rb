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

  def become
    return unless current_user.is_admin?
    sign_in(:user, User.find(params[:id]))
    redirect_to root_url # or user_root_url
  end

  private

end
