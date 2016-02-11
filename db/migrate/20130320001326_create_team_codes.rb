class CreateTeamCodes < ActiveRecord::Migration
  def change
    create_table :team_codes do |t|
      t.string  :data
      t.integer :state
      t.string  :color
      t.float   :bonus, null: false, default: 0
      t.integer :team_bonus_id

      t.references :team, null: false
      t.references :code, null: false
      t.references :zone
      t.references :game,   null: false

      t.timestamps
    end

    add_index :team_codes, :team_id
    add_index :team_codes, :code_id
    add_index :team_codes, [:game_id, :team_id, :code_id], unique: true
    add_index :team_codes, :zone_id
    add_index :team_codes, :game_id
    add_index :team_codes, :team_bonus_id
  end
end
