class CreateTeamBonus < ActiveRecord::Migration
  def change
    create_table :team_bonus do |t|
      t.string :bonus_type, null: false
      t.float :rate
      t.integer :amount

      t.references :team, null: false
    end

    add_index :team_bonus, :team_id
  end
end