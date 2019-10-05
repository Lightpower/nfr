# encoding: UTF-8
class Code < ActiveRecord::Base

  has_one :hold_zone, class_name: 'Zone', foreign_key: 'code_id'
  has_one :hold_task, class_name: 'Task', foreign_key: 'code_id'
  belongs_to :task
  belongs_to :game
  has_many :code_strings

  # TODO: change attr_accessible for new rains
  # attr_accessible :game, :game_id, :info, :ko, :name, :number, :parent_id, :type, :code_strings, :color, :bonus, :task, :task_id
  accepts_nested_attributes_for :code_strings

  STATES = [:accepted, :accessed, :repeated, :not_found, :not_available, :not_enough_costs,
            :hint_accessed, :hint_repeated, :hint_not_enough_costs, :attached
  ]
  STATE_NAMES = {accepted: 'принят', accessed: 'код доступа', repeated: 'повторно',
                 not_found: 'не принят', not_available: ' не принят', not_enough_costs: 'слишком дорого',
                 hint_accessed: 'получена подсказка', hint_repeated: 'повторно', hint_not_enough_costs: 'слишком дорого',
                 attached: 'распределён'
  }
  STATE_COLORS = {accepted: 'green', accessed: '#003c00', repeated: 'yellow', not_found: 'grey',
                  not_available: 'grey', not_enough_costs: 'red',
                  hint_accessed: '#662900', hint_repeated: 'darkyellow', hint_not_enough_costs: 'red', attached: 'green'
  }

  class << self
    ##
    # Ordered by number
    #
    def by_order
      order('codes.number')
    end
  end

  ##
  # Define Zone which this code belongs to.
  # if task_id is null return null, otherwise ask the task about its zone.
  #
  # Returns:
  # - {Zone} Zone if any or nil if this is the multizone code
  def zone
    hold_zone || task.try(:zone) || hold_task.try(:zone)
  end

  ##
  # Show code by name or by the first code_string
  #
  def show_code
    return name if name.present?
    code_strings.first.try(:data)
  end
end
