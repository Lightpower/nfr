# encoding: UTF-8
class Experience < ActiveRecord::Base

  belongs_to :format
  belongs_to :user

  # TODO: change attr_accessible for new rains
  # attr_accessible :null, :one, :one_p, :two, :two_p, :three, :tree_p, :nonstandard, :author, :format_id, :user_id
end
