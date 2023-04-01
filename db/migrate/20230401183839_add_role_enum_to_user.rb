class AddRoleEnumToUser < ActiveRecord::Migration[7.0]
  def up
    create_enum :user_role, ["reader", "editor", "admin"]
    add_column :users, :role, :enum, enum_type: :user_role, default: "reader", null: false
  end

  # There's no built in support for dropping enums
  def down
    remove_column :users, :role

    execute <<-SQL
      DROP TYPE user_role;
    SQL
  end
end
