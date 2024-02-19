class HouseImage < ApplicationRecord
  belongs_to :house

  def self.ransackable_attributes(_auth_object = nil)
    %w[blob_id created_at id name record_id record_type]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[house image_attachment image_blob]
  end
end
