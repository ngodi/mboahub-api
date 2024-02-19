class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[addressable_id addressable_type city country created_at id lat lng state street
       updated_at]
  end
end
