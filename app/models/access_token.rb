class AccessToken < ApplicationRecord
  has_secure_token

  belongs_to :user

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at id token updated_at user_id]
  end
end
