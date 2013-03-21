class CreateTeamZones < ActiveRecord::Migration
  def change
    create_table :team_zones do |t|
      t.references :team
      t.references :zone
    end

    add_index :team_zones, [:team_id, :zone_id], unique: true
  end
end
