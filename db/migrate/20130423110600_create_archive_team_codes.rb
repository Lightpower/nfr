class CreateArchiveTeamCodes < ActiveRecord::Migration
  def change
    create_table :archive_team_codes do |t|
      t.string  :data
      t.integer :state
      t.string  :color
      t.float   :bonus, null: false, default: 0

      t.references :team, null: false
      t.references :code, null: false
      t.references :zone
      t.references :team_bonus
      t.references :game,         null: false

      t.datetime :created_at
      t.datetime :updated_at
    end

  end
end
