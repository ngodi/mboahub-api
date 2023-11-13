class User < ApplicationRecord
  has_many :houses
  has_many :addresses, as: :addressable, dependent: :destroy
  has_many :sent_messages, class_name: 'Message', foreign_key: 'sender_id'
  has_many :received_messages, class_name: 'Message', foreign_key: 'receiver_id'
  has_many :received_messages, class_name: 'AnonymousMessage', foreign_key: 'receiver_id'

  after_initialize :init

  has_secure_password

  VALID_EMAIL_REGEX = /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*
                       [A-Za-z0-9]+@((\w+-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/i

  validates :email, presence: true, uniqueness: { case_sensetive: false }

  def name
    name = "#{first_name} #{last_name}"
    @name ||= name.empty? ? email.split('@').first : name
  end

  def house_count
    @house_count ||= houses.count
  end

  def exchanged_users
    User.joins('JOIN messages ON (users.id = messages.sender_id OR users.id = messages.receiver_id)')
      .where('users.id != ? AND (messages.sender_id = ? OR messages.receiver_id = ?)', id, id, id)
      .distinct
  end

  private

  def init
    first_name || ''
    last_name || ''
  end
end
