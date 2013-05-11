class CodeString < ActiveRecord::Base

  belongs_to :code
  belongs_to :game

  attr_accessible :game, :game_id, :code, :code_id, :data, :color

  before_save :downcase_code

  private

  def downcase_code
    self.data.downcase!
  end
end
