class CreateArchiveTeamZones < ActiveRecord::Migration
  def change
    create_table :archive_team_zones do |t|
      t.references :archive_team
      t.references :archive_zone
      t.references :game,         null: false
    end
  end
end
