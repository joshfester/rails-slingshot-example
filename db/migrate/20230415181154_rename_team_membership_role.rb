class RenameTeamMembershipRole < ActiveRecord::Migration[7.0]
  def up
    execute <<-SQL
      ALTER TYPE team_membership_role RENAME TO membership_role;
    SQL
  end

  def down
    execute <<-SQL
      ALTER TYPE membership_role RENAME TO team_membership_role;
    SQL
  end
end
