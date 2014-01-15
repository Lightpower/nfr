# encoding: UTF-8
module ApplicationHelper

  ##
  #  Show flash messages
  #
  def show_flash
    [:notice, :alert, :error].map { |type|
      content_tag(:div, flash[type].html_safe, class: type) if flash[type]
    }.join.html_safe
  end

  ##################################
  # Game helpers ###################
  ##################################

  ##
  # Show codes in each zone
  #
  def zone_information
    result = ''
    team = current_user.team

    if current_user.is_admin?
      @game.teams.each do |t|
        if t.game_zones(@game).size > 0
          result << content_tag(:tr, content_tag(:td, t.name))

          t.game_zones(@game).each do |zone|
            zone_html =  content_tag(:td, content_tag(:b, "#{zone.name}:") )
            zone_html << content_tag(:td, t.codes_number_in_zone(zone).round(3) )

            result << content_tag(:tr, zone_html)
          end
        end
      end
    else
      team.game_zones(@game).each do |zone|
          zone_html =  content_tag(:td, content_tag(:b, "#{zone.name}:") )
          zone_html << content_tag(:td, team.codes_number_in_zone(zone).round(3) )

          result << content_tag(:tr, zone_html)
      end
    end

    # Free zone
    if team.codes_number_in_zone(nil) > 0
      zone_html =  content_tag(:td, content_tag(:b, "В резерве -") )
      zone_html << content_tag(:td, team.codes_number_in_zone(nil).round(3) )
    end

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
    team.logs.order('logs.created_at DESC').first(20).each do |log|
      state = Code::STATES[log.result_code]
      style = case state
                when :accepted
                  'color:green;font-weight:bold;'
                when :accessed
                  'color:darkgreen;font-weight:bold;'
                else
                  'color:black;'
              end
      log_html = content_tag(:td, content_tag(:span, log.created_at.localtime.strftime('%H:%M:%S')))
      log_html << content_tag(:td, content_tag(:span, log.data[0..31], style: style))
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
    caption << content_tag(:span, 'Бонусы команды', class: 'caption')

    result = caption + result
    content_tag(:div, result.html_safe, class: 'blitz_info openable_holder').html_safe
  end

  ##
  # Helper for openable link with ID creating
  #
  def openable_tag(id, is_open=true, extra_caption='')
    sign = is_open ? '[-]' : '[+]'
    caption = content_tag(:span, sign, class: 'sign') + extra_caption
    params = { href: '#', class: 'openable'}
    params.merge!(id: id) if id.present?
    content_tag(:a, caption, params).html_safe
  end
end