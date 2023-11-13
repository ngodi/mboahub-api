FactoryBot.define do
  factory :message do
    content { 'MyText' }
    sender { nil }
    receiver { nil }
  end
end
