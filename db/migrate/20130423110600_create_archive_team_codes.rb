class CreateArchiveTeamCodes < ActiveRecord::Migration
  def change
    create_table :archive_team_codes do |t|
      t.string  :data
      t.integer :state
      t.string  :color
      t.float   :bonus, null: false, default: 0

      t.references :archive_team, null: false
      t.references :archive_code, null: false
      t.references :archive_zone
      t.references :game,         null: false

      t.datetime :created_at
      t.datetime :updated_at
    end

  end
end
