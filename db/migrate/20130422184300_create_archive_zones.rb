class CreateArchiveZones < ActiveRecord::Migration
  def change
    create_table :archive_zones do |t|
      t.integer :number,    null: false, unique: true
      t.string  :name,      null: false, unique: true
      t.string  :image_url
      t.text    :preview

      t.references :code
      t.references :game, null: false
    end
  end
end
