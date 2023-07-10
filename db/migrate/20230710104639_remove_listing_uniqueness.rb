class RemoveListingUniqueness < ActiveRecord::Migration[6.1]
  def change
    remove_index :houses, [:listing_name, :user_id]
  end
end
