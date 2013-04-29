class CreateGameRequests < ActiveRecord::Migration
  def change
    create_table :game_requests do |t|
      t.boolean :is_accepted, null: false, default: false

      t.references :game, null: false
      t.references :team, null: false

      t.timestamps
    end

    add_index :game_requests, [:game_id, :team_id], unique: true
  end
end
