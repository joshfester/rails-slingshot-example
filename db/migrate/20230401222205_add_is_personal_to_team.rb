class AddIsPersonalToTeam < ActiveRecord::Migration[7.0]
  def change
    add_column :teams, :is_personal, :boolean, null: false, default: false
  end
end
