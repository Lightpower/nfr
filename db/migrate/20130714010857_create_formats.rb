class CreateFormats < ActiveRecord::Migration
  def change
    create_table :formats do |t|
      t.string :name,              null: false
      t.string :css_class

      t.references :project
    end

    add_index :formats, :name, unique: true
    add_index :formats, :project_id
  end

end
