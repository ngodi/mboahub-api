class UpdateHouse < ActiveRecord::Migration[6.1]
  def change
    add_column :houses, :street, :string, null: false
    add_column :houses, :country, :string, null: false
    add_column :houses, :city, :string, null: false
    add_column :houses, :lat, :float
    add_column :houses, :lng, :float
    remove_column :houses, :properties, :jsonb
    add_column :houses, :num_bed_rooms, :integer
    add_column :houses, :sitting_room, :integer
    add_column :houses, :kitchen, :integer
    add_column :houses, :fence, :boolean
    add_column :houses, :parking, :boolean
    add_column :houses, :num_toilets, :integer
  end
end
