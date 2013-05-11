# encoding: UTF-8
class ArchiveCode < ActiveRecord::Base

  has_one :hold_zone, class_name: 'ArchiveZone', foreign_key: 'code_id'
  has_one :hold_task, class_name: 'ArchiveTask', foreign_key: 'code_id'

  has_many :archive_code_strings, class_name: 'ArchiveCodeString', foreign_key: 'code_id'

  belongs_to :archive_task, class_name: 'ArchiveTask', foreign_key: 'task_id'
  belongs_to :game

  attr_accessible :game, :game_id, :info, :ko, :name, :number, :parent_id, :type, :code_strings, :color, :bonus, :arcive_task, :task_id
  accepts_nested_attributes_for :archive_code_strings

  class << self
    ##
    # Ordered by number
    #
    def by_order
      order("archive_codes.number")
    end
  end

  ##
  # Define Zone which this code belongs to.
  # if task_id is null return null, otherwise ask the task about its zone.
  #
  # Returns:
  # - {Zone} Zone if any or nil if this is the multizone code
  def archive_zone
    hold_zone || archive_task.try(:archive_zone) || hold_task.try(:archive_zone)
  end

  ##
  # Show code by name or by the first code_string
  #
  def show_code
    return name if name.present?
    archive_code_strings.first.try(:data)
  end
end
