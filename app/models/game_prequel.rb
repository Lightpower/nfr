# encoding: UTF-8
class GamePrequel < ActiveRecord::Base

  belongs_to :game
  belongs_to :zone

  ##
  # Check if team finished this prequel
  #
  def is_finished_by?(team)
    ! zone.tasks.map {|task| task.is_finished?(team) }.include?(false) rescue false
  end
end
