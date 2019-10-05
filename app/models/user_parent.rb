# encoding: UTF-8
class UserParent < ActiveRecord::Base

  belongs_to :user

  # TODO: change attr_accessible for new rains
  # attr_accessible :id, :name
end
