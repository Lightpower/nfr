class CreateFormats < ActiveRecord::Migration
  def change
    create_table :formats do |t|
      t.string :name,              null: false
      t.string :organizer
      t.boolean :show_in_archives, null: false, default: true

      t.references :project
    end

    add_index :formats, :name, unique: true
  end

end
