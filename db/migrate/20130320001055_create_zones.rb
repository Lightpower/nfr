class CreateZones < ActiveRecord::Migration
  def change
    create_table :zones do |t|
      t.integer :number,    null: false, unique: true
      t.string  :name,      null: false, unique: true
      t.string  :image_url
      t.text    :preview

      t.references :game,   null: false
      t.references :code
    end

    add_index :zones, :game_id
    add_index :zones, :number, unique: true
    add_index :zones, :name,   unique: true
  end
end
