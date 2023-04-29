class RemoveOwnerIdFromTeam < ActiveRecord::Migration[7.0]
  def change
    remove_column :teams, :owner_id, :bigint
  end
end
