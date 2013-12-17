# encoding: UTF-8
module ProjectsHelper

  ##
  # Make HTML with projects names for header menu
  #
  def projects_header_menu
    return '' if @games.blank?

    menu_items =
        [ {name: 'Всё', class: ''} ] +
        Project.by_order.all.map {|project| {name: project.name, class: project.css_class}} +
        [ {name: 'Другие', class: 'other'} ]

    result = ''
    menu_items.each do |item|
      result << content_tag(:li, link_to(item[:name], '#', class: 'header_menu_item', 'data-class' => item[:class])).html_safe
    end
    content_tag(:ul, result.html_safe, class: 'header_menu').html_safe
  end

end
