 class Zone < ActiveRecord::Base

  has_many   :teams, through: :team_zones
  has_many   :team_zones
  has_many   :team_codes
  has_many   :tasks
  has_many   :zone_holders
  belongs_to :access_code, class_name: 'Code', foreign_key: 'code_id'

  attr_accessible :name, :number, :image_url, :access_code, :code_id

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
end
