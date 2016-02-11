# encoding: UTF-8
class Zone < ActiveRecord::Base

  has_many   :teams, through: :team_zones
  has_many   :team_zones
  has_many   :team_codes
  has_many   :tasks
  has_many   :zone_holders
  belongs_to :access_code, class_name: 'Code', foreign_key: 'code_id'
  belongs_to :game

  CLASS_NAMES = {
      'Север' => 'north',
      'Замковый Утёс' => 'casterly',
      'Дорн' => 'dorn',
      'Штормовые Земли' => 'storm',
      'Речные Земли' => 'river',
      'Соль и Камень' => 'salt',
      'Долина Аррен' => 'arren'
  }

  class << self

    ##
    # Ordering by number
    #
    def by_order
      order('zones.number')
    end
  end

  ##
  # Define the holder of this zone and the time of capturing
  #
  def holder(time=Time.now)
    zone_holders.where('time <= ?', time).order('zone_holders.time DESC').first
  end

  ##
  # Generate autoincrement task number
  #
  def new_task_number
    tasks.size + 1
  end

  ##
  # Make the ID for interface
  #
  def make_id
    "#{self.class.name.downcase}#{id}"
  end

  ##
  # Returns CSS class style for current zone
  #
  def css_class
    CLASS_NAMES[name]
  end
end
