# encoding: UTF-8
class Level < ActiveRecord::Base

  belongs_to :format

  # TODO: change attr_accessible for new rains
  # attr_accessible :format_id, :number, :scores, :name, :desc
end
