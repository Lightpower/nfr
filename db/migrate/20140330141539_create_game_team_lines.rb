class CreateGameTeamLines < ActiveRecord::Migration
  def change
    create_table :game_team_lines do |t|
      t.integer    :num,     null: false
      t.references :game,    null: false
      t.references :team,    null: false
      t.references :task,    null: false
      t.datetime   :start_at
      t.datetime   :finish_at
      t.boolean    :stopped,    null: false, default: false
    end

    add_index :game_team_lines, :game_id
    add_index :game_team_lines, :team_id
    add_index :game_team_lines, [:game_id, :team_id, :num]
    add_index :game_team_lines, :task_id
  end
end
