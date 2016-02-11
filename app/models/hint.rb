class Hint < ActiveRecord::Base

  belongs_to :task
  belongs_to :game
  has_many   :team_hints

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
