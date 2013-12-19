class AddNewFieldsToGames < ActiveRecord::Migration
  def change
    change_table :games do |t|
      t.boolean :is_visible,        default: false, null: false
      t.boolean :auto_teams_accept, default: false, null: false
    end
  end
end
