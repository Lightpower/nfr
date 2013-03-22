class Code < ActiveRecord::Base

  attr_accessible :info, :ko, :name, :number, :parent_id, :type

  ##
  # Define Zone which this code belongs to
  #
  def zone
    case type
      when "ZoneCode"
        Zone.find parent_id
      when "TaskCode"
        Task.find(parent_id).try(:zone)
      else
        nil
    end
  end

  def task
    case type
      when "TaskCode"
        Task.find parent_id
      else
        nil
    end
  end

end
