# encoding: UTF-8
class Project < ActiveRecord::Base

  has_many :formats
  has_many :games,    through: :formats

  class << self
    ##
    # Ordered by number
    #
    def by_order
      order("projects.position desc")
    end
  end

  ##
  # Games of this Project
  #
  def games
    self.formats.map(&:games).flatten
  end

  def url
    super || "/games?project_id=#{id}"
  end

end
