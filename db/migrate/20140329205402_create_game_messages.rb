class CreateGameMessages < ActiveRecord::Migration
  def change
    create_table :game_messages do |t|
      t.references :game,   null: false
      t.references :team
      t.boolean    :from_admin,   default: true
      t.string     :message_type, default: 'notice', null: false
      t.text       :data

      t.timestamps
    end

    add_index :game_messages, :game_id,  null: false
    add_index :game_messages, :team_id,  null: false
  end
end
