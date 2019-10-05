# encoding: UTF-8
class Mailout < ActiveRecord::Base

  belongs_to :game

  # TODO: change attr_accessible for new rains
  # attr_accessible :game, :game_id

  class << self
    def by_date
      order('mailouts.created_at DESC')
    end
  end
end
