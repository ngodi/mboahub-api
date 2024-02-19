class UpdateHouseUser < ActiveRecord::Migration[6.1]
  def change
    change_column_null(:houses, :user_id, true)
  end
end
