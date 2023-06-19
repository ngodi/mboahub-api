class House < ApplicationRecord
  belongs_to :user
  has_many :house_images

  validates :listing_name, presence: true, uniqueness: { case_sensetive: false }

  jsonb_accessor :location,
                 city: :string,
                 street: :string,
                 country: :string,
                 lat: :string,
                 lng: :string

  jsonb_accessor :properties,
                 num_bed_rooms: :integer,
                 sitting_room: :integer,
                 parking: :boolean,
                 kitchen: :integer,
                 fence: :boolean,
                 num_toilets: :integer

  def published_at
    created_at.strftime('%Y-%m-%d')
  end
end
