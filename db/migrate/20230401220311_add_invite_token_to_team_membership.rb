class AddInviteTokenToTeamMembership < ActiveRecord::Migration[7.0]
  def change
    add_column :team_memberships, :invite_token, :string
    add_index :team_memberships, :invite_token, unique: true
  end
end
