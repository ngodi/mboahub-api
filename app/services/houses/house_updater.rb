module Houses
  class HouseUpdater
    attr_reader :user, :house_params, :images

    def initialize(user:, house_params:, images: nil)
      @user = user
      @house_params = house_params
      @images = images
    end

    def update!
      House.update!(user_id: user.id).merge(house_params)
    end
  end
end
