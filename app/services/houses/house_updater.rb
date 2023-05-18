module Houses
  class HouseUpdater
    attr_reader :user, :house_params, :images

    def initialize(user:, house_params:, images: nil)
      @user = user
      @house_params = house_params
      @images = images
    end

    def update!
      House.update!(user_id: user.id).merge(house_params).tap do |house|
        images&.map do |image|
          HouseImages.update!(image_url: image, house_id: house.id)
        end
      end
    end
  end
end
