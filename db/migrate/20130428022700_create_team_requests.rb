class CreateTeamRequests < ActiveRecord::Migration
  def change
    create_table :team_requests do |t|
      t.boolean :by_user

      t.references :team
      t.references :user
    end

    add_index :team_requests, :team_id
    add_index :team_requests, :user_id
    add_index :team_requests, :by_user
  end
end
