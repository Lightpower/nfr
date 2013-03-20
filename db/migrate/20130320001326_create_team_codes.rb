class CreateTeamCodes < ActiveRecord::Migration
  def change
    create_table :team_codes do |t|
      t.integer :team_id
      t.integer :code_id
      t.string :data

      t.timestamps
    end
  end
end
