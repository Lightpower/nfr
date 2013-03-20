class CreateCodes < ActiveRecord::Migration
  def change
    create_table :codes do |t|
      t.string :type
      t.integer :number
      t.string :name
      t.string :info
      t.string :ko
      t.integer :parent_id

      t.timestamps
    end
  end
end
