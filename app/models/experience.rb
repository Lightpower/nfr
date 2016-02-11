# encoding: UTF-8
class Experience < ActiveRecord::Base

  belongs_to :format
  belongs_to :user

end
