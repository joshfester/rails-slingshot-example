class RenameTeamMembership < ActiveRecord::Migration[7.0]
  def change
    rename_table :team_memberships, :memberships
  end
end
