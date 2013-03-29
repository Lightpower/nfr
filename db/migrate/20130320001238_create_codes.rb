class CreateCodes < ActiveRecord::Migration
  def change
    create_table :codes do |t|
      t.integer :number,  null: false
      t.string  :name,    null: false
      t.string  :info
      t.string  :ko,      null: false
      t.string  :color
      t.float   :bonus,   null:false, default: 0

      t.references :task
    end

    add_index :codes, :number
    add_index :codes, :ko
  end
end
