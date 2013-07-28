module GameStrategy

  ##
  # Strategy for Game with game_type = "conquest"
  #
  module Line
    extend GameStrategy::Line::Actions
    extend GameStrategy::Line::Rendering
    extend GameStrategy::Line::ActionPanel
  end
end