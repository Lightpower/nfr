# encoding: UTF-8
class Mailout < ActiveRecord::Base

  belongs_to :game

  class << self
    def by_date
      order('mailouts.created_at DESC')
    end
  end
end
