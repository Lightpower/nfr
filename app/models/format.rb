# encoding: UTF-8
class Format < ActiveRecord::Base

  has_many   :games
  belongs_to :project

  scope :of_project, lambda { |project_id| where(project_id: project_id) }
end
