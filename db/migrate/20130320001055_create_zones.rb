class CreateZones < ActiveRecord::Migration
  def change
    create_table :zones do |t|
      t.integer :number,    null: false
      t.string  :name,      null: false
      t.string  :image_url
      t.text    :preview      

      t.references :game,   null: false
      t.references :code
    end

    add_index :zones, :game_id
    add_index :zones, [:game_id, :number], unique: true
    add_index :zones, [:game_id, :name], unique: true
  end
end