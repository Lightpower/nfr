# encoding: UTF-8
class Domain < ActiveRecord::Base

  has_many :users
end
