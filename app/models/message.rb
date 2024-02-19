class Message < ApplicationRecord
  has_and_belongs_to_many :users
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'

  validates_presence_of :content

  def self.ransackable_attributes(_auth_object = nil)
    %w[content created_at id receiver_id sender_id updated_at]
  end
end
