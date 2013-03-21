class ZoneCode < Code

  belongs_to :zone, foreign_key: :parent_id

  attr_accessible :info, :ko, :name, :number, :parent_id
end
