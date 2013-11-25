class CreateCodeStrings < ActiveRecord::Migration
  def change
    create_table :code_strings do |t|
      t.string :data,     null: false, unique: true
      t.string :color

      t.references :code, null: false
      t.references :game,   null: false
    end

    add_index :code_strings, :data, unique: true
    add_index :code_strings, :code_id
    add_index :code_strings, :game_id
  end
end
