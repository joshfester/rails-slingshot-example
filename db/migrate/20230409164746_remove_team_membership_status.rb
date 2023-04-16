class RemoveTeamMembershipStatus < ActiveRecord::Migration[7.0]
  def up
    remove_column :team_memberships, :status, :enum
    execute <<-SQL
      DROP TYPE team_membership_status;
    SQL
  end

  def down
    create_enum :team_membership_status, ["pending", "active"]
    add_column :team_memberships, :status, :enum, enum_type: :team_membership_status, default: "pending", null: false
  end
end
