class User < ApplicationRecord
  has_many :houses
  has_many :addresses, as: :addressable, dependent: :destroy

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

  private

  def init
    first_name || ''
    last_name || ''
  end
end
