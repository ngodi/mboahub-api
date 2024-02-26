class AnonymousMessage < ApplicationRecord
  belongs_to :house
  belongs_to :receiver, class_name: 'User'

  enum role: { read: 'read', replied: 'replied', received: 'received' }.freeze

  validates_presence_of :content, :sender_email, :sender_phone, :sender_name

  def self.ransackable_attributes(_auth_object = nil)
    %w[content created_at house_id id receiver_id sender_email sender_name sender_phone
       updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[house receiver]
  end
end
