class AddUserIdToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :user_id, :integer

    Team.all.each do |team|
      team.captain = team.users.order(:id).first
      if team.captain.blank?
        team.delete
      else
        team.save
      end
    end

    change_column :teams, :user_id, :integer, null: false

    add_index :teams, :user_id
  end
end
