class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name,             null: false
      t.string :alternative_name
      t.string :image_url

      t.references :user, null: false
    end

    add_index :teams, :name
    add_index :teams, :user_id
  end
end