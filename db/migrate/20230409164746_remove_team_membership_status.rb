class RemoveTeamMembershipStatus < ActiveRecord::Migration[7.0]
  def change
    remove_column :team_memberships, :status
    execute <<-SQL
      DROP TYPE team_membership_status;
    SQL
  end
end
