class Log < ActiveRecord::Base

  belongs_to :team
  belongs_to :code


  attr_accessible :data, :team, :team_id, :login, :result_code, :code, :code_id
end
