class CreateZones < ActiveRecord::Migration
  def change
    create_table :zones do |t|
      t.integer :number
      t.string :name


      t.timestamps
    end
  end
end
