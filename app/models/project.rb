# encoding: UTF-8
class Project < ActiveRecord::Base

  has_many :formats
  has_many :games,    through: :formats

  attr_accessible :id, :name, :owner

  ##
  # Games of this Project
  #
  def games
    self.formats.map(&:games).flatten
  end

end
