# encoding: UTF-8
module ApplicationHelper

  ##
  #  Show flash messages
  #
  def show_flash
    [:notice, :alert, :error].map { |type|
      content_tag(:div, flash[type], class: type) if flash[type]
    }.join.html_safe
  end

  ##
  # Show codes in each zone
  #
  def zone_information
    result = ''
    team = current_user.team
    team.zones.each do |zone|
      zone_html =  content_tag(:td, content_tag(:b, "#{zone.name}:") )
      zone_html << content_tag(:td, team.codes_number_in_zone(zone).round(3) )

      result << content_tag(:tr, zone_html)
    end

    # Free zone
    zone_html =  content_tag(:td, content_tag(:b, "В резерве -") )
    zone_html << content_tag(:td, team.codes_number_in_zone(nil) )

    result << content_tag(:tr, zone_html)

    result = content_tag(:table, result.html_safe, class: 'quick_stat')
    result.html_safe
  end

  ##
  # Get last log records
  #
  def show_log(number=20)
    result = ''
    team = current_user.team
    team.logs.first(20).each do |log|
      state = Code::STATES[log.result_code]
      style = case state
                when :accepted
                  'color:green;font-weight:bold;'
                when :accessed
                  'color:darkgreen;font-weight:bold;'
                else
                  'color:black;'
              end
      log_html = content_tag(:td, content_tag(:span, log.created_at.strftime('%H:%M:%S')))
      log_html << content_tag(:td, content_tag(:span, log.data, style: style))
      log_html << content_tag(:td, content_tag(:span, Code::STATE_NAMES[state]))

      result << content_tag(:tr, log_html)
    end

    result = content_tag(:table, result.html_safe, class: 'logs')
    result.html_safe
  end

  ##
  # Makes div with information about team bonus
  #
  def team_bonus_div(team)
    return '' if team.blank? || team.team_bonuses.blank?

    result = ''
    team.team_bonuses.each do |bonus|
      result << content_tag(:p, "<b>#{bonus.name}</b><br>#{bonus.description}".html_safe)
    end
    result = content_tag(:div, result.html_safe, class: 'openable').html_safe

    caption = openable_tag('team_bonuses')
    caption << content_tag(:span, 'Бонусы Дома', class: 'caption')

    result = caption + result
    content_tag(:div, result.html_safe, class: 'blitz_info openable_holder').html_safe
  end

  ##
  # Helper for openable link with ID creating
  #
  def openable_tag(id)
    content_tag(:a, '- ', href: '#', class: 'openable', id: id).html_safe
  end
end