# encoding: UTF-8
module ProjectsHelper

  ##
  # Make HTML with projects names for header menu
  #
  def projects_header_menu
    menu_items =
        [ {name: 'Всё', url: '/'} ] + Project.by_order.all.map {|project| {name: project.name, url: "/?games[project]=#{project.css_class}"}} + [ {name: 'Другие', url: '/?games[project]=other'} ]

    result = ''
    menu_items.each do |item|
      result << link_to(item[:name], item[:url], class: 'header_menu_item').html_safe
    end
    result.html_safe
  end

end
