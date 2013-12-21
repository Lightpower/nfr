class UpdateGamesAndCodes < ActiveRecord::Migration
  def change
    change_table :games do |t|
      t.change_default :game_type, 'conquest'
    end

    change_table :codes do |t|
      t.change :info, :text
    end
  end
end
