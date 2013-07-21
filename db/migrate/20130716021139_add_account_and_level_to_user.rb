class AddAccountAndLevelToUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.float   :account, default: 0
      t.integer :level
    end
  end
end
