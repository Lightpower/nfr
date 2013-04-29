# encoding: UTF-8
class Game < ActiveRecord::Base

  has_many :codes
  has_many :code_strings
  has_many :requests, class_name: "GameRequest"
  has_many :hints
  has_many :logs
  has_many :tasks
  has_many :team_bonuses
  has_many :team_bonus_actions
  has_many :team_codes
  has_many :team_hints
  has_many :team_zones
  has_many :zones

  attr_accessible :number, :name, :format, :start_date, :finish_date, :price, :area, :image_html, :preview,
                  :legend, :brief_place, :dopy_list, :is_active, :is_archived,  :prepare_url, :discuss_url

  ##
  # List of teams with accepted requests
  #
  def teams
    requests.where(is_accepted: true).map(&:team).flatten
  end

  ##
  # List of teams with unaccepted requests
  #
  def teams_unaccepted
    requests.where(is_accepted: false).map(&:team).flatten
  end
end
