class AddIndexToTables < ActiveRecord::Migration[6.1]
  def change
    add_index :users, :id, unique: true
    add_index :houses, :id, unique: true
    add_index :house_images, :id, unique: true
  end
end
