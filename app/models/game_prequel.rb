# encoding: UTF-8
class GamePrequel < ActiveRecord::Base

  belongs_to :game
  belongs_to :zone

  attr_accessible :game_id, :zone_id, :start_at, :is_active, :bonus

  ##
  # Check if team finished this prequel
  #
  def is_finished_by?(team)
    ! zone.tasks.map {|task| task.is_finished?(team) }.include?(false)
  end
end
