# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

admin = AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') # if Rails.env.development?

users = (1..5).to_a.map do |n| 
  User.create!(email: "test_user#{n}@gmail.com", 
                password: '12345678',
                first_name: "test#{n}",
                last_name: "user#{n}", 
                image_url: Faker::Avatar.image(slug: "my-own-slug", size: "50x50", format: "jpg"),
                image_cover_url: Faker::Avatar.image(slug: "my-own-slug", size: "50x50", format: "jpg"),
                about: Faker::Lorem.paragraph,
                phone: Faker::PhoneNumber.cell_phone_with_country_code
    ).tap do |user|
      user.addresses.create!(
        street: Faker::Address.street_address,
        city: Faker::Address.city,
        state: Faker::Address.state,
        country: Faker::Address.country 
      )
    end
end

users[0].update!(role: 'admin')

30.times do 
  user = users.sample
  listing_name = Faker::Name.unique.name
  summary = Faker::Lorem.paragraph
  home_type = ['apartment', 'studio', 'room'].sample
  cost = 10000
  city = Faker::Address.city
  country = Faker::Address.country
  street = Faker::Address.street_address
  num_bed_rooms = [1, 2, 3].sample
  sitting_room = [1, 2, 3].sample
  kitchen = Faker::Boolean.boolean
  fence = Faker::Boolean.boolean
  num_toilets = [1, 2, 3].sample

  ActiveRecord::Base.transaction do
    user.houses.create!(
      admin_user: admin,
      listing_name: listing_name, 
      summary: summary, 
      home_type: home_type, 
      cost: cost, 
      business_type: ['for_sale', 'for_rent'].sample,
      num_bed_rooms: num_bed_rooms, 
      sitting_room: sitting_room, 
      city: city,
      country: country,
      street: street,
      kitchen: kitchen, 
      fence: fence, 
      num_toilets: num_toilets
      ).tap do |house|
      3.times do
        # HouseImage.create!(image_url: Faker::LoremFlickr.image, house_id: house.id)
        # house.images.attach(io: URI.open(Faker::LoremFlickr.image), filename: Faker::LoremFlickr.image)
      end
    end
  end
end
