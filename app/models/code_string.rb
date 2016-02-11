class CodeString < ActiveRecord::Base

  belongs_to :code
  belongs_to :game

  before_save :downcase_code

  private

  def downcase_code
    self.data.downcase!
  end
end
