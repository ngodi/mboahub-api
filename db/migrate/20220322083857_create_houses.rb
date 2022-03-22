class CreateHouses < ActiveRecord::Migration[6.1]
  def change
    create_table :houses, id: :uuid do |t|
      t.references :user, null: false, type: :uuid, foreign_key: true
      t.string :listing_name, null: false
      t.string :summary
      t.string :home_type, null: false
      t.string :cost, null: false
      t.jsonb :location, null: false
      t.jsonb :properties

      t.timestamps
    end

    add_index :houses, [:listing_name, :user_id], unique: true
  end
end
