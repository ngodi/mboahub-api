class Message < ApplicationRecord
  has_and_belongs_to_many :users
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'

  validates_presence_of :content
end
