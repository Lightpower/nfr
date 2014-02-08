class CreateTeamCorrections < ActiveRecord::Migration
  def change
    create_table :team_corrections do |t|
      t.float    :bonus
      t.text     :description
      t.boolean  :is_active

      t.references :game
      t.references :team
      t.references :zone
    end

    add_index :team_corrections, :game_id
    add_index :team_corrections, :team_id
    add_index :team_corrections, :zone_id

    create_table :archive_team_corrections do |t|
      t.float    :bonus
      t.text     :description
      t.boolean  :is_active

      t.references :game
      t.references :team
      t.references :zone
    end

    add_index :archive_team_corrections, :game_id
    add_index :archive_team_corrections, :team_id
    add_index :archive_team_corrections, :zone_id
  end
end
