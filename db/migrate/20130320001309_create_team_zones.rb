class CreateTeamZones < ActiveRecord::Migration
  def change
    create_table :team_zones do |t|
      t.references :team
      t.references :zone
      t.references :game,   null: false
    end

    add_index :team_zones, [:game_id, :team_id, :zone_id], unique: true
    add_index :team_zones, :game_id
  end
end
