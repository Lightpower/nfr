# encoding: UTF-8
class Format < ActiveRecord::Base

  has_many   :games
  belongs_to :project

  attr_accessible :id, :project_id, :name, :css_class, :organizer, :show_in_archives
end
