class AddBonusIdToTeamCode < ActiveRecord::Migration
  def change
    add_column :team_codes, :team_bonus_id, :integer
    add_index  :team_codes, :team_bonus_id
  end
end
