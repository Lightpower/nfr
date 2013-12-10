# encoding: UTF-8
class Admins::SqlController < ApplicationController
  before_filter :authenticate_user!
  authorize_resource class: false

  def index
  end

  def create
    @sql = params[:sql][:to_s]
    begin
      result = ActiveRecord::Base.connection.execute(@sql)
      @cmd_tuples = result.cmd_tuples
      flash[:error]   = result.error_message if result.error_message.present?
      flash[:notice] = 'success' if result.error_message.blank?
      @response = result.to_a
    rescue Exception => e
      flash[:error] = e.message
    end

    render action: :index
  end

  private

end
