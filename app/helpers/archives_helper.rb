# encoding: UTF-8
module ArchivesHelper

  ##
  # Create links to all details
  #
  def links(game)
    return '' unless game
    res = link_to('Описание', '#', class: 'archive_link')
    res << link_to('Статистика', '#', class: 'archive_link')
    res << link_to('Обсудить', '#', class: 'archive_link')
    res
  end
end
