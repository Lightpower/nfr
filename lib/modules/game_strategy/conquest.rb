module GameStrategy

  ##
  # Strategy for Game with game_type = "conquest"
  #
  module Conquest
    extend GameStrategy::Conquest::Actions
    extend GameStrategy::Conquest::Rendering
    #extend GameStrategy::Conquest::ActionPanel
  end
end