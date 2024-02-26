class House < ApplicationRecord
  belongs_to :user
  belongs_to :admin_user
  has_many_attached :images

  validates_presence_of :listing_name, :summary, :home_type, :cost, :city, :num_bed_rooms, :business_type

  BUSINESS_TYPE = { for_sale: 'for_sale', for_rent: 'for_rent' }.freeze
  enum business_type: BUSINESS_TYPE

  HOME_TYPE = {
    room: 'room',
    studio: 'studio',
    apartment: 'apartment',
    duplex: 'duplex',
    land: 'land'
  }.freeze

  def published_at
    created_at.strftime('%Y-%m-%d')
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[business_type city cost country created_at dimensions fence has_title home_type id
       kitchen lat listing_name lng num_bed_rooms num_toilets parking sitting_room street summary total_area updated_at user_id]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[house_images user]
  end
end
