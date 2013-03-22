class TeamBonus < ActiveRecord::Base
  belongs_to :team
  attr_accessible :amount, :bonus_type, :rate
end
