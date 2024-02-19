class AnonymousMessage < ApplicationRecord
  belongs_to :house
  belongs_to :receiver, class_name: 'User'

  validates_presence_of :content, :sender_email, :sender_phone, :receiver_id, :house_id, :sender_name

  def self.ransackable_attributes(_auth_object = nil)
    %w[content created_at house_id id receiver_id sender_email sender_name sender_phone
       updated_at]
  end
end
