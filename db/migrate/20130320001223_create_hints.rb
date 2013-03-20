class CreateHints < ActiveRecord::Migration
  def change
    create_table :hints do |t|
      t.integer :number
      t.string :data
      t.integer :delay
      t.integer :cost

      t.timestamps
    end
  end
end
