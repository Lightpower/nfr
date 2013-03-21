class CreateCodes < ActiveRecord::Migration
  def change
    create_table :codes do |t|
      t.string  :type,    null: false, default: 'TaskCode'
      t.integer :number,  null: false
      t.string  :name,    null: false
      t.string  :info
      t.string  :ko,      null: false

      t.references :parent
    end

    add_index :codes, :type
    add_index :codes, :number
    add_index :codes, :ko
    add_index :codes, :parent_id
  end
end
