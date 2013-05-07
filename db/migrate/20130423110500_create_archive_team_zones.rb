class CreateArchiveTeamZones < ActiveRecord::Migration
  def change
    create_table :archive_team_zones do |t|
      t.references :team
      t.references :zone
      t.references :game,         null: false
    end
  end
end
