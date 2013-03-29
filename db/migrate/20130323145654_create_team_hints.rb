class CreateTeamHints < ActiveRecord::Migration
  def change
    create_table :team_hints do |t|
      t.float :cost, null:false, default: 0

      t.references :team
      t.references :hint
      t.references :zone

      t.timestamps
    end

    add_index :team_hints, :hint_id
    add_index :team_hints, :team_id
    add_index :team_hints, :zone_id
  end
end
