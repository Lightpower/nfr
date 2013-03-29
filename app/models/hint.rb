class Hint < ActiveRecord::Base

  belongs_to :task
  has_many   :team_hints

  attr_accessible :cost, :data, :delay, :number, :task, :task_id

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


end
