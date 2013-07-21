# encoding: UTF-8
class Level < ActiveRecord::Base

  belongs_to :format

  attr_accessible :format_id, :number, :scores, :name, :desc
end
