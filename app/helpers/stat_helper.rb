# encoding: UTF-8
module StatHelper

  ##
  # Make table row with zone information
  #
  # Params:
  # - params {Hash} Data about zone
  #
  # Example of data:
  #     {
  #       name: 'Casterly Rocks',
  #       holder: {
  #         name: 'Lannisters',
  #         codes: 11,
  #         time: '03:03:17',
  #         image: '/images/starks.png',
  #         team_codes: 12,
  #       },
  #     }
  #
  def show_stat_row(params)
    result = ""
    result << content_tag(:td, content_tag(:b, params[:name]), class: 'zone_name')
    if params[:holder][:image].present?
      result << content_tag(:td, content_tag(:img, src: params[:holder][:image], width: 16, height: 16))
    else
      result << content_tag(:td)
    end
    result << content_tag(:td, params[:holder][:name])
    result << content_tag(:td, params[:holder][:codes])
    result << content_tag(:td, params[:holder][:time])
    result << content_tag(:td, params[:team_codes])

    content_tag(:tr, result.html_safe)
  end


  ##
  # Make div block with zone information
  #
  # Params:
  # - params {Hash} Data about zone
  #
  # Example of data:
  #     {
  #       name: 'Casterly Rocks',
  #       holder: {
  #         name: 'Lannisters',
  #         codes: 11,
  #         time: '03:03:17',
  #         image: '/images/starks.png',
  #         team_codes: 12,
  #       },
  #     }
  #
  def show_zone_stat(params)
    res = ''
    res << content_tag(:span, params[:name], class: 'zone_title')
    res << '<br>'
    res << content_tag(:span, 'Хозяин: ', class: 'label')
    res << content_tag(:span, params[:holder][:name], class: 'holder')
    res << '<br>'
    res << content_tag(:span, 'Влияние: ', class: 'label')
    res << content_tag(:span, params[:holder][:codes], class: 'codes')
    res << '<br>'
    res << content_tag(:span, 'Время захвата: ', class: 'label')
    res << content_tag(:span, params[:holder][:time], class: 'time')
    res << '<br>'
    res << content_tag(:span, 'Ваше влияние в зоне: ', class: 'label')
    res << content_tag(:span, params[:team_codes], class: 'team_codes')

    content_tag(:div, res.html_safe, class: "div_#{params[:name].gsub(' ','').underscore}").html_safe
  end
end
