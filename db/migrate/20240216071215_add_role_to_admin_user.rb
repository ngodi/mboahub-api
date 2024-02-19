class AddRoleToAdminUser < ActiveRecord::Migration[6.1]
  def change
    add_column :admin_users, :role, :string, default: 'agent', null: false
  end
end
