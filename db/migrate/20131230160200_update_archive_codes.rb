class UpdateArchiveCodes < ActiveRecord::Migration
  def change
    change_table :archive_codes do |t|
      t.change :info, :text
    end
  end
end
