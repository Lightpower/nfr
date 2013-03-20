class Code < ActiveRecord::Base
  attr_accessible :info, :ko, :name, :number, :parent_id, :type
end
