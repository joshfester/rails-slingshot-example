class RenameTeamMembershipRole < ActiveRecord::Migration[7.0]
  def change
    execute <<-SQL
      ALTER TYPE team_membership_role RENAME TO membership_role;
    SQL
  end
end
