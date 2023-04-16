class RemoveInviteTokenFromTeamMembership < ActiveRecord::Migration[7.0]
  def change
    remove_column :team_memberships, :invite_token, :string
  end
end
