# encoding: UTF-8
class UserParent < ActiveRecord::Base

  belongs_to :user

  attr_accessible :id, :name
end
