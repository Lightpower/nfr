class CreateTeamBonusActions < ActiveRecord::Migration
  def change
    create_table :team_bonus_actions do |t|
      t.boolean :is_ok

      t.references :team_bonus
      t.references :game,   null: false

      t.timestamps
    end

    add_index :team_bonus_actions, :team_bonus_id
    add_index :team_bonus_actions, :game_id
  end
end
