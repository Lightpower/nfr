# encoding: UTF-8
module GamesHelper

  ##
  # Create link_to for deleting game_request from user
  #
  def link_to_delete_game_request(game, user)
    return '' unless user.is_captain?
    game_request = GameRequest.where(game_id: game.id, team_id: user.try(:team).try(:id)).first
    link_to 'Удалить заявку', game_request_path(game_request), method: :delete, class: 'delete_game'
  end

  ##
  # Create link_to for creating game_request WITHOUT USER DEFINING!
  # This request should be created for current_user
  #
  def link_to_create_game_request(game)
    link_to 'Подать заявку', game_requests_path(game_request: {game_id: game.id}), method: :post, class: 'request_game'
  end

  ##
  # Create link_to for enter the game
  #
  def link_to_enter_game(game)
    link_to 'Вход в игру', game_path(game), class: 'enter_game'
  end

  ##
  # Create link_to for edit game data
  #
  def link_to_edit_game(game)
    link_to 'Править игру', edit_creators_game_path(game), class: 'edit_game'
  end

  ##
  # Create link_to for archive game
  #
  def link_to_archive_game(game)
    link_to 'Заархивировать', archive_game_path(game), class: 'archive_game', confirm: 'Заархивировать игру?'
  end
end
