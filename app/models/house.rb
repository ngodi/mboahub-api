class House < ApplicationRecord
  belongs_to :user
  has_many :house_images

  jsonb_accessor :location,
      city: :string,
      street: :string

  jsonb_accessor :properties,
      num_bed_rooms: :integer,
      sitting_room: :integer,
      parking: :boolean,
      kitchen: :integer,
      fence: :boolean,
      num_toilets: :integer

  def published_at
    created_at.strftime("%Y-%m-%d")
  end
end
