ActiveAdmin.register User do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at
  #
  # or
  #
  # permit_params do
  #   permitted = [:email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at]
  #   permitted
  # end

  permit_params :email

  filter :email
  filter :reset_password_sent_at
  filter :remember_created_at
  filter :remember_created_at
  filter :created_at
  filter :updated_at

  index do
    selectable_column
    column :id
    column :email
    column :reset_password_sent_at
    column :remember_created_at
    column :created_at
    column :updated_at
  end
  
end
