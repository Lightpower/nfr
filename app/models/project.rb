# encoding: UTF-8
class Project < ActiveRecord::Base

  has_many :formats
  has_many :games,    through: :formats

  attr_accessible :id, :name, :css_class, :owner

  class << self
    ##
    # Ordered by number
    #
    def by_order
      order("projects.id")
    end
  end

  ##
  # Games of this Project
  #
  def games
    self.formats.map(&:games).flatten
  end

end
