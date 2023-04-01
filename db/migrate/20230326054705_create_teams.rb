class CreateTeams < ActiveRecord::Migration[7.0]
  def change
    create_table :teams do |t|
      t.string :title
      t.references :owner, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
