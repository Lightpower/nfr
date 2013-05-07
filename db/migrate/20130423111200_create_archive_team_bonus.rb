class CreateArchiveTeamBonus < ActiveRecord::Migration
  def change
    create_table :archive_team_bonus do |t|
      t.string  :bonus_type, null: false
      t.string  :name,       null: false
      t.text    :description
      t.float   :rate
      t.string  :ko
      t.integer :amount

      t.references :team_bonus
      t.references :team, null: false
      t.references :game,         null: false
    end

  end
end
