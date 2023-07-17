class AddFieldsToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :image_url, :string
    add_column :users, :image_cover_url, :string
    add_column :users, :agency, :string
    add_column :users, :about, :text
    add_column :users, :phone, :integer
    add_column :users, :facebook_url, :string
    add_column :users, :twitter_url, :string
    add_column :users, :instagram_url, :string
  end
end
