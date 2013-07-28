module GameMethods
  class Line

    validate :check_game_type

    ##
    #
    #
    def current_zone(team)

    end

    def current_task(team)

    end

    private

    def check_game_type
      errors.add(:game_type, "cannot call method of GameMethods::Line for Game with type '#{self.game_type}'") if self.game_type.classify != 'Line'
    end
  end
end