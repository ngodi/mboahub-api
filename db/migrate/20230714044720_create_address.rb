class CreateAddress < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :city
      t.string :state
      t.string :country
      t.float :lat
      t.float :lng
      t.integer :addressable_id
      t.string :addressable_type

      t.timestamps
    end
  end
end
