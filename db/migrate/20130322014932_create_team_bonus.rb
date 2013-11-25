class CreateTeamBonus < ActiveRecord::Migration
  def change
    create_table :team_bonus do |t|
      t.string  :bonus_type, null: false
      t.string  :name,       null: false
      t.text    :description
      t.float   :rate
      t.string  :ko
      t.integer :amount

      t.references :team, null: false
      t.references :game,   null: false
    end

    add_index :team_bonus, :team_id
    add_index :team_bonus, :game_id
  end
end
