class CreateInvitations < ActiveRecord::Migration[7.0]
  def change
    create_table :invitations do |t|
      t.string :email, null: false
      t.references :from_membership, null: false, foreign_key: { to_table: :team_memberships }
      t.enum :role, enum_type: :team_membership_role, default: "member", null: false
      t.references :team, null: false, foreign_key: true

      t.timestamps
    end
  end
end
