class CreateHouseImages < ActiveRecord::Migration[6.1]
  def change
    create_table :house_images, id: :uuid do |t|
      t.references :house, null: false, type: :uuid, foreign_key: true
      t.string :image_url, null: false

      t.timestamps
    end
  end
end
