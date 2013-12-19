# encoding: UTF-8
module TeamsHelper

  ##
  # Show preview for not allowed tasks
  #
  # Params:
  # - params {Hash}:
  #   - exclude {Array of Integer} - List of ID's of team that should be excluded from the list
  #   - f {ActionView::Helpers::FormBuilder} - builder of form which this select belongs to
  #
  def team_select(params)
    user = params[:user]
    f = params[:f]
    if user.is_captain?
      content_tag(:span, user.team.name)
    else
      team_collection = Team.all.reject{|team| user.team_requests.map(&:team_id).include? team.id}.collect {|team| [team.name, team.id] }
      if f
        f.select(:team_id, team_collection, {include_blank: "<команда не выбрана>"})
      else
        select_tag(:team_id, team_collection, {include_blank: "<команда не выбрана>"})
      end
    end
  end

  ##
  # Show team link as pretty div
  #
  def link_to_team(team_or_id)
    team = team_or_id.is_a?(Team) ? team_or_id : Team.find(team_or_id) rescue nil
    return '' if team.blank?

    ret_val = link_to(team.name, team_path(team), class: 'team_link')

    content_tag(:div, ret_val, class: 'team_link')
  end

end
