class CreateArchiveTeams < ActiveRecord::Migration
  def change
    create_table :archive_teams do |t|
      t.string :name,             null: false
      t.string :alternative_name
      t.string :image_url

      t.references :team
      t.references :game, null: false
    end
  end
end
