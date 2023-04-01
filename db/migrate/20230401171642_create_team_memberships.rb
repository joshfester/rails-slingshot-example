class CreateTeamMemberships < ActiveRecord::Migration[7.0]
  def up
    create_enum :team_membership_status, ["pending", "active"]
    create_enum :team_membership_role, ["member", "admin"]

    create_table :team_memberships do |t|
      t.references :team, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.enum :status, enum_type: :team_membership_status, default: "pending", null: false
      t.enum :role, enum_type: :team_membership_role, default: "member", null: false

      t.timestamps
    end
  end

  # There's no built in support for dropping enums
  def down
    drop_table :team_memberships

    execute <<-SQL
      DROP TYPE team_membership_status;
      DROP TYPE team_membership_role;
    SQL
  end
end
