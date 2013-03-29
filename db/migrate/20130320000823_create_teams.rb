class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name,             null: false
      t.string :alternative_name
      t.string :image_url
    end

    add_index :teams, :name
  end
end
