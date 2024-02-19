class AddFieldsToHouse < ActiveRecord::Migration[6.1]
  def change
    add_column :houses, :has_title, :boolean
    add_column :houses, :dimensions, :string
    add_column :houses, :total_area, :integer
  end
end
