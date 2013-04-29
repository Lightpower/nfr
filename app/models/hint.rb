class Hint < ActiveRecord::Base

  belongs_to :task
  belongs_to :game
  has_many   :team_hints

  attr_accessible :game, :game_id, :cost, :data, :delay, :number, :task, :task_id

  class << self
    ##
    # Ordered by number
    #
    def by_order
      order("hints.number")
    end
  end

  ##
  # Does this hint got by defined team
  #
  def is_got_by_team?(team)
    TeamHint.where(team_id: team.id, hint_id: self.id).present?
  end

  ##
  # Make the ID for interface
  #
  def make_id
    "#{self.class.name.downcase}#{id}"
  end
end
