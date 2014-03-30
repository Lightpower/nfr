# encoding: UTF-8
class Domain < ActiveRecord::Base

  has_many :users
  attr_accessible :id, :name, :full_name, :owner
end
