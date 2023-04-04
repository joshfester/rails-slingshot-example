class AddDeletedAtToTeam < ActiveRecord::Migration[7.0]
  def change
    add_column :teams, :deleted_at, :datetime
  end
end
