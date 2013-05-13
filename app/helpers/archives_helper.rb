# encoding: UTF-8
module ArchivesHelper

  ##
  # Create links to all details
  #
  def links(game)
    return '' unless game
    res = link_to('Описание', archive_path(game), class: 'archive_link')
    res << link_to('Результаты', short_stat_archive_path(game), class: 'archive_link')
    res << link_to('Статистика', wide_stat_archive_path(game), class: 'archive_link')
    if game.discuss_url.present?
      res << link_to('Обсудить', game.discuss_url, class: 'archive_link')
    else
      res << link_to('Обсудить', '#', class: 'archive_link')
    end
    res
  end
end
