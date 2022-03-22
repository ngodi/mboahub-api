module Houses
    class HouseCreator
        attr_reader :user, :house_params, :images

        def initialize(user:, house_params:, images: nil)
            @user = user
            @house_params = house_params
            @images = images
        end

        def create!
          ActiveRecord::Base.transaction do
            user.houses.create!(house_params).tap do |house|
              images && images.map do |image|
                  HouseImage.create!(image_url: image, house_id: house.id)
              end
            end
          end
        end
    end
end
