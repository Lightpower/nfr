# encoding: UTF-8
class Domain < ActiveRecord::Base

  has_many :users
  # TODO: change attr_accessible for new rains
  # attr_accessible :id, :name, :full_name, :owner
end
