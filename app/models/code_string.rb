class CodeString < ActiveRecord::Base

  belongs_to :code

  attr_accessible :code, :code_id, :data

  before_save :downcase_code

  private

  def downcase_code
    self.data.downcase!
  end
end
