class CreateTeamZones < ActiveRecord::Migration
  def change
    create_table :team_zones do |t|
      t.integer :team_id
      t.integer :zone_id

      t.timestamps
    end
  end
end
