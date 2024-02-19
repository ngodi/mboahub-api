class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  has_many :houses

  ADMIN = 'admin'
  AGENT = 'agent'

  enum role: { admin: ADMIN, agent: AGENT }.freeze

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at email encrypted_password id remember_created_at reset_password_sent_at
       reset_password_token role updated_at]
  end
end
