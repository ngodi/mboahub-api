class House < ApplicationRecord
  belongs_to :user
  has_many :house_images

  enum business_type: { for_sale: 'for_sale', for_rent: 'for_rent' }

  def published_at
    created_at.strftime('%Y-%m-%d')
  end
end
