class CreateArchiveTeamHints < ActiveRecord::Migration
  def change
    create_table :archive_team_hints do |t|
      t.float :cost

      t.references :archive_team
      t.references :archive_hint
      t.references :archive_zone
      t.references :game,         null: false

      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
