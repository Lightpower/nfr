class ArchiveCodeString < ActiveRecord::Base

  belongs_to :archive_code, class_name: 'ArchiveCode', foreign_key: 'code_id'
  belongs_to :game

  attr_accessible :game, :game_id, :archive_code, :code_id, :data

  before_save :downcase_code

  private

  def downcase_code
    self.data = Unicode::downcase(self.data)
  end
end
