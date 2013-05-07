class CreateArchiveTeamHints < ActiveRecord::Migration
  def change
    create_table :archive_team_hints do |t|
      t.float :cost

      t.references :team
      t.references :hint
      t.references :zone
      t.references :game,         null: false

      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
