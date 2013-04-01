# encoding: UTF-8
module StatHelper

  ##
  # Show preview for not allowed tasks
  #

  #     2 => {
  #       name: 'Casterly Rocks',
  #       holder: {
  #         name: 'Lannisters',
  #         codes: 11,
  #         time: '03:03:17',
  #         image: '/images/starks.png',
  #         team_codes: 12,
  #       },
  #     }

  def show_stat_row(params)
    result = ""
    result << content_tag(:td, content_tag(:b, params[:name]), class: 'zone_name')
    result << content_tag(:td, content_tag(:img, src: params[:holder][:image], width: 16, height: 16)) if params[:holder][:image].present?
    result << content_tag(:td, params[:holder][:name])
    result << content_tag(:td, params[:holder][:codes])
    result << content_tag(:td, params[:holder][:time])
    result << content_tag(:td, params[:team_codes])

    content_tag(:tr, result.html_safe)
  end
end
