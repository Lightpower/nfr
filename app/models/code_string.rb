class CodeString < ActiveRecord::Base

  belongs_to :code

  attr_accessible :code_id, :data
end
