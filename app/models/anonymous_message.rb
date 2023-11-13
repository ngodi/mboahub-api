class AnonymousMessage < ApplicationRecord
  belongs_to :house
  belongs_to :receiver, class_name: 'User'

  validates_presence_of :content, :sender_email, :sender_phone, :receiver_id, :house_id, :sender_name
end
