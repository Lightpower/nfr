class CreateProjects < ActiveRecord::Migration
  class Project < ActiveRecord::Base ; end

  def change
    create_table :projects do |t|
      t.integer :position, null: false, default: 1000
      t.string  :name,     null: false
      t.string  :en_name
      t.string  :url
      t.string  :image_url
    end

    add_index :projects, :name, unique: true
    add_index :projects, :position
  end
end
