# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

houses = House.all
users = User.all

30.times do 
  user = users.sample
  listing_name = Faker::Name.unique.name
  summary = Faker::Lorem.paragraph
  home_type = ['apartment', 'studio', 'room'].sample
  cost = 10000
  city = Faker::Address.city
  street = Faker::Address.street_address
  num_bed_rooms = [1, 2, 3].sample
  sitting_room = [1, 2, 3].sample
  kitchen = Faker::Boolean.boolean
  fence = Faker::Boolean.boolean
  num_toilets = [1, 2, 3].sample

  ActiveRecord::Base.transaction do
    user.houses.create!(
      listing_name: listing_name, 
      summary: summary, 
      home_type: home_type, 
      cost: cost, 
      city: city, 
      street: street, 
      num_bed_rooms: num_bed_rooms, 
      sitting_room: sitting_room, 
      kitchen: kitchen, 
      fence: fence, 
      num_toilets: num_toilets
      ).tap do |house|
      3.times do
        HouseImage.create!(image_url: Faker::LoremFlickr.image, house_id: house.id)
      end
    end
  end
end