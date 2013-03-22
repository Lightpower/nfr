class Log < ActiveRecord::Base

  belongs_to :team

  attr_accessible :data, :team, :team_id, :user_id
end
