class CreateGameConfig < ActiveRecord::Migration
  def change
    create_table :game_configs do |t|
      t.integer :time
      t.integer :bonus
      t.integer :total_bonus

      t.references :game
    end

    add_index :game_configs, :game_id, null: false, unique: true

    if Rails.env != 'test'
      Game.all.each { |game| GameConfig.create(game_id: game.id, time: 1800, bonus: 45, total_bonus: 420) }
    end
  end
end
