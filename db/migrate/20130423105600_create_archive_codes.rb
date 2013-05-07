class CreateArchiveCodes < ActiveRecord::Migration
  def change
    create_table :archive_codes do |t|
      t.integer :number,  null: false
      t.string  :name,    null: false
      t.string  :info
      t.string  :ko,      null: false
      t.string  :color
      t.float   :bonus,   null:false, default: 0

      t.references :task
      t.references :game, null: false
    end
  end
end
