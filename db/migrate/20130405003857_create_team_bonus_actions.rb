class CreateTeamBonusActions < ActiveRecord::Migration
  def change
    create_table :team_bonus_actions do |t|
      t.references :team_bonus
      t.boolean :is_ok

      t.timestamps
    end

    add_index :team_bonus_actions, :team_bonus_id
  end
end
