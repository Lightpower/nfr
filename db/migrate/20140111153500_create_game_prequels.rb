class CreateGamePrequels < ActiveRecord::Migration
  def change
    create_table :game_prequels, id: false do |t|
      t.datetime :start_at
      t.boolean  :is_active
      t.float    :bonus

      t.references :game
      t.references :zone
    end

    add_index :game_prequels, :game_id, unique: true
    add_index :game_prequels, :zone_id, unique: true
  end
end
