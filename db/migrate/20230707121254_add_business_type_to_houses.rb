class AddBusinessTypeToHouses < ActiveRecord::Migration[6.1]
  def change
    add_column :houses, :business_type, :string
  end
end
