# encoding: UTF-8
class MobileController < ApplicationController
  before_filter :authenticate_user!
  before_filter :validate_team_presence

  def index
    # Codes processing
    if params[:code_string].present?
      @results = CodeFacade.input({code_string: params[:code_string][:code], user: current_user})
    elsif params[:task_id].present?
      @results = [CodeFacade.get_hint({task_id: params[:task_id], user: current_user})]
    else
      @results = nil
    end

    render 'mobile/index', locals: {input_url: m_path}, layout: 'layouts/mobile'
  end

  private

  def validate_team_presence
    raise(CanCan::AccessDenied, 'В доступе отказано: пользователь не привязан ни к одному Дому.') if current_user.team.blank?
  end

end
