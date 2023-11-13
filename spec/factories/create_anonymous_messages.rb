FactoryBot.define do
  factory :create_anonymous_message do
    email { 'MyString' }
    phone { 'MyString' }
    house { nil }
    receiver { nil }
    content { 'MyText' }
  end
end
