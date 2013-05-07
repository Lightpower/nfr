class ArchiveHint < ActiveRecord::Base

  belongs_to :archive_task
  belongs_to :game
  has_many   :archive_team_hints

  attr_accessible :game, :game_id, :cost, :data, :delay, :number, :archive_task, :task_id

  class << self
    ##
    # Ordered by number
    #
    def by_order
      order("archive_hints.number")
    end
  end

  ##
  # Does this hint got by defined team
  #
  def is_got_by_team?(archive_team)
    ArchiveTeamHint.where(team_id: archive_team.id, hint_id: self.id).present?
  end

  ##
  # Make the ID for interface
  #
  def make_id
    "#{self.class.name.downcase}#{id}"
  end
end
