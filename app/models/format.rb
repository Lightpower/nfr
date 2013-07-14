# encoding: UTF-8
class Format < ActiveRecord::Base

  has_many :games

  attr_accessible :id, :project_id, :name, :organizer, :show_in_archives
end
