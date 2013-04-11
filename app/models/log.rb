class Log < ActiveRecord::Base

  belongs_to :team
  belongs_to :code

  attr_accessible :data, :team, :team_id, :login, :result_code, :code, :code_id

  def can_show_info?
    ! [Code::STATES.index(:not_found), Code::STATES.index(:not_available)].include?(self.result_code)
  end

end
