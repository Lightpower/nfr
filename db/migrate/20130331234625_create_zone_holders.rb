class CreateZoneHolders < ActiveRecord::Migration
  def change
    create_table :zone_holders do |t|
      t.float      :amount,    null: false
      t.references :zone,      null: false
      t.references :team,      null: false
      t.references :team_code

      t.datetime :time

      t.timestamps
    end

    add_index :zone_holders, :zone_id
    add_index :zone_holders, :team_id
    add_index :zone_holders, :team_code_id
  end
end
