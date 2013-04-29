# encoding: UTF-8
class UpdateGameIndices < ActiveRecord::Migration
  def change
    # Zone
    change_column :zones, :number, :integer, null: false
    change_column :zones, :name, :string, null: false
    remove_index :zones, :number
    remove_index :zones, :name
    add_index :zones, [:game_id, :number], unique: true
    add_index :zones, [:game_id, :name], unique: true

    # Hint
    remove_index :hints, [:number, :task_id]
    add_index :hints, [:game_id, :number, :task_id], unique: true

    #CodeString
    change_column :code_strings, :data, :string, null: false
    remove_index :code_strings, :data
    add_index :code_strings, [:game_id, :data], unique: true

    # TeamZones
    remove_index :team_zones, [:team_id, :zone_id]
    add_index :team_zones, [:game_id, :team_id, :zone_id], unique: true

    # TeamCodes
    remove_index :team_codes, [:team_id, :code_id]
    add_index :team_codes, [:game_id, :team_id, :code_id], unique: true
  end
end
