class AddAdminUserToHouse < ActiveRecord::Migration[6.1]
  def change
    add_column :houses, :admin_user_id, :bigint
  end
end
